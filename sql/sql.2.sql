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
p_sitter_id VARCHAR(30),
p_applic_id VARCHAR(30),
p_regDate DATETIME


)

CREATE TABLE p_booking


SELECT * FROM p_member

