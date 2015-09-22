##R

1. install.packages("packagesName")
   install.packages(c("package1", "package2"))

2. library(packagesName) // #include

3. getwd()
   setwd("/home/ly/code/ml/r")
   dir()

4. 注释符号 ##

5. x <- 1 //赋值
   x <- 1:20
   print(x) or x

6. Objects

    Numbers
     1L for integer
     1 is double
     Inf 
     NaN

   Attributes

7. explicit coercion
    class(x) ##显示x的类型
	as.numeric(x)
	as.logical(x)
    as.character(x)
	as.complex(x)

8. Vectors
   Vectors 需要都是同一类型 (class(vector) 会输出该vector内元素类型)
		x <- c(1.7, "a") ##使用两者公共最低类型 character
		x <- c(0.5, 0.6) ##numeric
    	x <- c(TRUE, T, FALSE, F) ##logical
		x <- c("a", "b", "c") ##character
		x <- c(1+0i, 2+4i) ##complex
    	x <- 9:29 ##integer
    	x <- vector("numeric", length = 10)
		x <- numeric(10) 
   List
		x <- list(1, "a", TRUE, 1 + 4i)
		list里的每一个元素还是一个list
		x[1]返回的是第一个list，x[[1]]则会将自带的list表示去掉后的元素返回

9. Matrices
	m <- matrix(nrow = 2, ncol = 3)
    m <- matrix(1:6, nrow = 2, ncol = 3)
    dim(m) ##返回维数
    dim(m) <- c(2, 5) ##把m向量转换为2*5矩阵
	cbind(x, y) ##把x，y两个向量作为列向量bind
	rbind(x, y)

10. Factors
	x <- factor(c("yes", "yes", "no"))
	table(x) ##输出每个因子出现的频率
	unclass(x) ##把该factor解码成integer
	x <- factor(c("yes", "yes", "no"), levels=c("yes","no")) ##该factor的yes为第一个水平

11. Missing Values
	is.na() 
	is.nan()

12. Data Frames
	x <- data.frame(foo = 1:4, bar = c(T,T,F,F))
	nrow(x)
	ncol(x)
	data.matrix() ##将data frames转换为matrix

13. Names
	x <- 1:3
	names(x) <- c("foo", "bar", "ok")
	x <- list(a = 1, b = 2, c = 3)
	m <- matrix(1:4, nrow=2, ncol=2)
	dimnames(m) <- list(c("a", "b"), c("c", "d")) ##前为列name，后为行name

14. Read
	readLines(file, nrow)
	read.table(file, header, sep)
	## file, the name of a file
	## header, 数据是否有首行
	## sep, 分隔符
	## colClasses, 给出每一列的数据类型 (colClasses = "numeric" 默认每一列都为)
	## nrows, 读取的行数
	## comment.char, 注释符号
	## skip, 
	## stringAsFactors, 
	read.csv()
	## 默认分隔符是，
	## 默认header为TRUE	
	
	R read all the data to physical memory
	if we use read.table, we need 2 times size of data in memory
	some strategy to read big data
	- comment.char = ""
	- initial <- read.table("data", nrows=100)
	  classes <- sapply(initial, class)
	  tabAll <- read.table("data", colClasses=classes)
	
15. Interfaces to the Outside World
	##插播黑科技.. str(函数名) 就可以看一个函数的接口	
	file() 
	gzfile() #connect to a file compressed with gzip
	bzfile() #connect to a file compressed with bzp
	url()
	con <- file("foo.txt", "r")
	data <- read.csv(con)
	close(con)
	con <- url("http://www.baidu.com", "r")
	x <- readLines(con)

16. Subsetting
		# numeric index OR logical index
		x <- c("a", "b", "c", "d")
		x[1] 
		x[1:4]
		x[x > "a"]
		x[x %in% 1:5]
		u <- x > "a"
		x[u]
	
	Subsetting List
		x <- list(foo = 1:4, bar = 0.6)
		x[1] , x[[1]]
		x$bar, x["bar"], x[["bar"]]
		x[c(1, 2)] #取出了第一个和第二个list
		name <- "foo"
		x$name (X) , x[[name]] (Y) #双括号里支持变量运算，美刀符号不支持
		x[[c(1, 2)]] 同于 x[[1]][[2]] #取出第一个list的第二个元素

	Subsetting Matrix
		x <- matrix(1:6, 2, 3)
		x[i] #取出第i个元素(一行一行的)
		x[1, 2] #取出第一行第二个元素 返回vector
		x[1, 2, drop = FALSE] #返回的是matrix

	Subsetting Data.frames
		x[i] #取出第i列，返回data.frames
		x[[i]] #取出第i列，返回vectors
		x[1,2] #同矩阵
	
	Subsetting Partial Matching
		x <- list(aardvark = 1:5)
		x$a 同于 x[["a", exact=FALSE]]

	Subsetting Removing Missing Values
		bad <- is.na(x)
		x[!bad]
		x <- c(1, 2, NA)
		y <- c("a", NA, "b")
		good <- complete.cases(x, y) #good for x, y both not na
		good <- complete.cases(x) when x is data.frame
	
17. Vectorized Operations


18. if () {} else {}
	y <- if () {} else {} ##括号里是个值..就像?:

19. for (i in 1:10){}
	for (i in seq_along(x)){} ##seq_along(x)创造一个与vector x等长的整数增长vector
	for (i in seq_len(x)){} ##seq_len(x)输入一个数，创造一个与该数等长的整数增长vector
	for (letter in x){} ##可以从任意vector/list中提取元素(注意list中也是提取元素)
	while (count <= 10 && count >= 3){} ##和C++一样..
	repeat{} ## while(1) +_+
	next ## continue +_+
	break ## 一样 +_+

20. Function
	add <- function(x, y){x + y} #R默认返回最后一个表达式的值, 函数也只是个对象
		Argument Matching	
			add(y = 2, passX) #赋值管赋值其余按顺序
			1. Check for exact match for a named argument
			2. Check for a partial match
			3. Check for a positional match
		只有当程序运行到没有缺省值也没有传值的参数的部分才会报错 LAZY EVALUTION
		Argument ...

21. Scoping rules
		search() ##可以查看每一个加载的"环境"
		我们使用library(）后，新加载的这一个包会排在全局环境之后
		scope对于变量的查找同样是不断找父环境，若已经到了顶层，则会按search里排出的那个顺序查找下一个环境
	Lexical scoping
		means: the values of free variables are searched for in the environment in which the function was defined
		environment: is a collection of (symbol, value) pairs / every environment has a parent environment except empty environment
		A function + an environment = a closure or function closure
		(parent frame : calling environment)
		考虑DEFINE这个函数的环境

22. Dates in R
	x <- as.Date("1970-01-01") #内部以1970-01-01开始的妙数计时
	x <- Sys.time() #获取当前系统时间
	p <- as.POSIXlt(x) #内部以list实现	
 	p <- as.POSIXct(x) #内部以大整数实现
==================================================================================================================
https://github.com/jtleek/datasharing

Tidy data

	Each variable you measure should be in one column

	Each different observation of that variable should be in a different row

	There should be one table for each "kind" of variable
[
	1. include a row at the top of each file with variable name
	
	2. make variable names human readable
		 
	3. in general data should be saved in one file per table
]

Code book

	Information about the variables(including units)

	Information about the summary choices you made

	Information about the erperimental study design you used

Instruction list


Some command for read
1. 
	absolute /home/ly/code/
	relative ./code

2. 
	if (!file.exists("data")){
		dir.create("data")	
	}

3. 
	download.file(fileUrl, destfile = "./data/use.csv", method = "curl")
	
4. 
	(Another package: XLConnect)
	Read xlsx (for xlsx packages) //sudo R CMD javareconf 配置好JAVA环境
	read.xlsx("./data.xlsx", sheetIndex = 1, header=TRUE)

5. 
	##这个包并没有试过..
	Read xml (for XML packages) //sudo apt-get install libxml2-dev
	
6. 
	Read json (for jsonlite packages)
	jsonData <- fromJSON(url)
	y <- toJSON(x, pretty=TRUE) ##pretty 是否漂亮的缩进

About data table packages
	

Read the data from different things
1. MySQL
	ustcDb <- dbConnect(MySQL(), user="", host="")
	result <- dbGetQuery(ustcDb, "show databases;")
	dbDisconnect(ustcDb)

	ustcOj <- dbConnect(MySQL(), user="", db="ustcOj", host="")
	dbDisconnect(ustcOj)
	allTables <- dbListTables(ustcOj)
	dbListFields(ustcOj, "user") #列出user表的项名
	userTable <- dbReadTable(ustcOj, "user") #获取user表

	query <- dbSendQuery(ustcOj, "MySQL command") #在远程执行命令，不讲数据拉回 
	result <- fetch(query, n = 10) #将数据拉回
	dbClearResult(query) #清除远程执行的命令

2. HDF5 // 不知道这是啥鬼类型。。没太记
	source("http://bioconductor.org/biocLite.R")
	biocLite("rhdf5")

	created = h5createFile("example.h5")
	created = h5createGroup("example.h5", "foo")
	h5ls("example.h5")
	h5write(A, "example.h5", "foo/A")

3. Web
	con = url("http://www.baidu.com")
	htmlCode = readLines(con)
	close(con)

	url <- "http://www.baidu.com"
	html <- htmlTreeParse(url, useInternalNodes=T)

	library(httr)
	html = GET(url)
	html2 = GET("http://cm0323.pw/wp-login.php", authenticate("user", "passwd"))
	content = content(html, as="text")
	parseHtml = htmlParse(content, asText=T)
	google = handle("http://google.com")
	pg1 = GET(handle=google, path="/")
	pg2 = GET(handle=google, path="search")

4. API
	myapp = oauth_app("twitter", key="", secret="")
	sig = sign_oauth1.0(myapp, token="", token_secret="")
	homeTL = GET("https://", sig)
	json1 = content(homeTL)
	json2 = jsonlite::fromJSON(toJSON(json1))
