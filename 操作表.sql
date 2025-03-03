use xxbg;
create table students(
    sid int, -- 编号作为数据类型，int作为数据类型直接写即可
    name varchar (10),-- 姓名作为字符串类型，varchar/char作为数据类型后面要加一个().里面写最多存储的字符数。
    gender char (1),-- 只有一个字(定长字符串)
    birthday date , -- 生日选择日期类型，只有年月日选择date类型
    score double(5,2), -- 分数选择为数据类型，double作为数据类型，不建议只写一个double，建议在double的后面加上一个(m,n),m:数字的最大位数(整+小) n:数字的最大位数(小)
    email varchar(64),-- 邮件选择字符串类型，选择varchar变长字符串，(邮件的地址长度不一样)
    phone varchar(20),
    status tinyint  -- 状态选择数字类型，由于状态不是特别多，选择tinyint
    );