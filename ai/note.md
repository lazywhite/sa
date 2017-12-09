machine learning
    不需要人为显式编程, 让计算机自己发现数据间的规律
supervised learning
    有明确的feature, label对应关系, 对以后的输入做预测
unsupervised learning
    没有给定feature与label间的对应, 仅对给出的数据集做分类
reinforcement
    给程序的输出做出反馈, 从而使算法更为精确


line regression 线性回归
    最优曲线满足最小差方和(square error cost function)
    weights, biases

7 step of machine learning
    gathering data
    prepareing data
        发现数据的不平衡
        切分为训练数据(80%)和测试数据(20%)
        去重
        修正错误
    choosing a model
        问题的类型: 图像, 音乐, 文本, 数字
    training
        对获得的结果进行修正, 进行重复训练
    evaluation(评估)
    hyperparameter tunning
    prediction
        
NLP: nature language processing
        


svm: supported vector machine
    hyperplan 超平面
    kernel function(trick)
        将原本线性不可分的数据集进行分割, 通过映射到高纬度来
        使其线性可分的方法
    k-fold crosss validation
DNN: deep neural network

decision tree(cart)
    classification and regression tree
    root node
        split
            decision node
            ternimal node
    缺点: overfitting(过拟合), 不稳定

artifical neural network
    Deep Neutal Network
        back propagation  反向传播
        convolution  卷积
        recurrent  递归

监督式学习
    分类方法
        决策树模型
        贝叶斯分类器
            通过贝叶斯公式计算对象属于某一类的概率
            p(E|H) =  p(H|E) *  P(E)/ P(E)
        支持向量机
            线性
            超平面

概率论与数理统计
统计学


特征值的选取
    1. 避免无用项作为特征, 要对分类起决定作用
    2. 避免冗余项作为特征, 不要相互包含或重叠
    3. 不会把问题复杂化


训练过的classifier可以使用pickle持久化
