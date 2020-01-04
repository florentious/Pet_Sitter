CREATE TABLE p_member(
m_id VARCHAR(30) PRIMARY KEY,
m_pwd VARCHAR(41) NOT NULL,
m_name VARCHAR(20) NOT NULL,
m_loc VARCHAR(50) NOT NULL,
m_phone VARCHAR(15) NOT NULL,
m_pet VARCHAR(30) NOT NULL,
m_img_path VARCHAR(150) NOT NULL,
m_comment VARCHAR(100) NOT NULL,
m_type TINYINT,

m_regdate DATETIME,
m_point INT,
m_point_count INT

);

CREATE TABLE notice(

n_no INT PRIMARY KEY,
n_regdate DATETIME,
n_title varchar(30) NOT NULL,
n_id varchar(30) NOT NULL,
n_contents VARCHAR(100) NOT null

);


CREATE TABLE p_wanted(
w_no INT PRIMARY KEY,
w_title VARCHAR(50),
w_content VARCHAR(1024),
w_regDate DATETIME,
w_isEnd BOOLEAN,
w_id VARCHAR(30),
foreign KEY (w_id) REFERENCES p_member(m_id)

);

CREATE TABLE p_point_date(
p_sitter_id VARCHAR(30) NOT null,
p_applic_id VARCHAR(30) NOT null,
p_regDate DATETIME,
PRIMARY KEY(p_sitter_id, p_applic_id)


)

CREATE TABLE p_comment(
c_no INT NOT NULL PRIMARY key,
c_wanted_no INT NOT null,
c_member_id VARCHAR(30) NOT NULL,
c_comment VARCHAR(256),
c_regdate DATETIME,

FOREIGN KEY (c_wanted_no) REFERENCES p_wanted(w_no),
FOREIGN KEY (c_member_id) REFERENCES p_member(m_id)

);

CREATE TABLE p_book(
b_no INT PRIMARY KEY,
b_wantedNo INT NOT NULL, 
b_applicId VARCHAR(30) NOT NULL,
b_content VARCHAR(256),

b_regDate DATETIME,
b_bookStart DATETIME,
b_bookEnd DATETIME,
b_isConfirm BOOLEAN,

FOREIGN KEY (b_wantedNo) REFERENCES p_wanted(w_no),
FOREIGN KEY (b_applicId) REFERENCES p_member(m_id)

);


