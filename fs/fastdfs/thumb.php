<?php
//防盗链判断
if (isset($_SERVER['HTTP_REFERER']) && $_SERVER['HTTP_REFERER'] && !preg_match("/mmbang|iyaya|babybang/", $_SERVER['HTTP_REFERER'])){
	header("Location:/blank.gif");
	exit;
}


set_time_limit(0);

//配置
$config['tmp_path'] = dirname(__FILE__).'/tmp';
$config['cache_path'] = dirname(__FILE__).'/cache';
$config['thumb_size'] = array(200=>array(200=>1), 120=>array(120=>1));


$url = isset($_GET['url']) ? trim($_GET['url']) : '';

//解析原始图片地址与缩放图片大小信息
$org_img_url = '';
$thumb_width = 0;
$thumb_height = 0;
$img_suffix = '';
if (preg_match("/([^=]+)=([0-9]+)x([0-9]+)\.(.+)/", $url, $matches)){
	$org_img_url = $matches[1];
	$thumb_width = $matches[2];
	$thumb_height = $matches[3];
	$img_suffix = $matches[4];
}

if (!$org_img_url){
	echo 'error code:1';
	exit;
}

//取得fastdfs fileid
$fileid  = url_to_fileid($org_img_url);
if (!$fileid){
	echo 'error code:2';
	exit;
}

$group_name = get_group_name_by_fileid($fileid);

//取得目录与文件名
$dir = '';
$filename = '';
if (preg_match("/group[0-9]+\/M[0-9]([0-9])(\/[^\/]+\/[^\/]+\/)(.+)/", $fileid, $matches)){
	$dir = 'data' . $matches[1] . '/data' . $matches[2];
	$filename = $matches[3];
}

//新增判断缓存文件是否存在
$cache_file_rel=$dir.$filename.'='.$thumb_width.'x'.$thumb_height.'.'.$img_suffix;
$cache_file = $config['cache_path'].'/'.$cache_file_rel;
if(file_exists($cache_file)){
	$image = fread(fopen($cache_file, 'rb'),filesize($cache_file));
	//输出图片
	header("Content-Type:image/jpeg");
	echo $image;
	exit();
}

//缩放大小判断
//if (!isset($config['thumb_size'][$thumb_width][$thumb_height])){
//	echo 'error code:4';
//	exit;
//}

$tracker = fastdfs_tracker_get_connection();
$storage = fastdfs_tracker_query_storage_store($group_name);

$tmp_fileid = $config['tmp_path']."/fastdfs_img_thumb_".md5($fileid).time();
//下载图片到临时目录
fastdfs_storage_download_file_to_file1($fileid, $tmp_fileid, 0, 0, $tracker, $storage);

if (!file_exists($tmp_fileid)){
    echo 'error code:5';
    exit;
}

//开始缩放
$image = new Imagick($tmp_fileid);
$image_width = $image->getImageWidth();
$image_height = $image->getImageHeight();
$max_width = $thumb_width;
$max_height = $thumb_height;

if($max_width>0 && $max_height>0){
	if($image_width>$max_width || $image_height>$max_height){
		$r1=$image_width/$max_width;
		$r2=$image_height/$max_height;
		if($r1>$r2){
			$image->thumbnailImage( $max_width, null );

		}else{
			$image->thumbnailImage( null, $max_height);
		}

	}

}else if($max_width>0){
	if($image_width>$max_width){
			$image->thumbnailImage( $max_width, null );
	}

}else if($max_height>0){
	if($image_height>$max_height){
			$image->thumbnailImage( null, $max_height );
	}
}

//cache缩放过的图片
if (!is_dir($config['cache_path'].'/'.$dir)){
	exec("mkdir -p {$config['cache_path']}/{$dir}");
}
$cache_file_rel=$dir.$filename.'='.$thumb_width.'x'.$thumb_height.'.'.$img_suffix;
$cache_file = $config['cache_path'].'/'.$cache_file_rel;
//记录图片缩放日志，默认不打开
file_put_contents(dirname(__FILE__)."/cache.log", date("YmdHis")."\t".$cache_file_rel."\n", FILE_APPEND);
$image->writeImage($cache_file);

//输出图片
header("Content-Type:image/jpeg");
echo $image;

$image->destroy();


//删除临时图片
if (file_exists($tmp_fileid)){
	unlink($tmp_fileid);
}

function url_to_fileid($url)
{
	$fileid = '';
	if (preg_match("/http:\/\/img01\.mmbang\.info\/[0-9]+iyaya_(group[0-9]+_[^_]+_[^_]+_[^_]+_)(.+)/i", $url, $matches)){
		if ($matches[1]){
			return str_replace('_', '/', $matches[1]).$matches[2];
		}
	}
	return $fileid;
}

function get_group_name_by_fileid($group_name)
{
        $file_info = explode("/", $group_name);
        return $file_info[0];
}

