import java.io.IOException;

import java.util.StringTokenizer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class AccessParser {
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "new");
        job.setJarByClass(AccessParser.class);
        job.setMapperClass(AccessMapper.class);
        job.setCombinerClass(AccessReducer.class);
        job.setReducerClass(AccessReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

    public static class AccessMapper extends Mapper<Object, Text, Text, IntWritable>{
        private final static IntWritable one = new IntWritable(1);
        private Text word =  new Text();

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException{
            StringTokenizer iter = new StringTokenizer(value.toString());
//            while (iter.hasMoreTokens()){
//                all.append(iter.nextToken());
//            }
            word.set(iter.nextToken());
            context.write(word, one);
        }
    }




    public static class AccessReducer 
            extends Reducer<Text, IntWritable, Text, IntWritable>{
            private IntWritable result = new IntWritable();

            public void reduce(Text key, Iterable<IntWritable> values,
                                Context context) throws IOException, InterruptedException{
                int sum = 0;
                for(IntWritable val: values){
                    sum += val.get();
                }
                result.set(sum);
                context.write(key, result);
            }
                
        }
}
