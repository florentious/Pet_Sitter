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

DROP TABLE p_member;

SELECT * FROM p_member;