package mc.sn.waw.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
//유저테이블 
public class MemberVO {
	 // 프라이머리 키 
    private Integer tid;
    // 아이디 
    private String id;
    // 비밀번호 
    private String pwd;
    // 비밀번호 확인 
    private String pwdRe;
    // 이름 
    private String name;
    // 닉네임 
    private String nickname;
    // 생년월일 
    private Date birth;
    // 성별 
    private String gender;
    // 휴대폰번호 
    private String phone;
    // 생성일 
    private Date creationDate;
    // 수정일 
    private Date modDate;

	public MemberVO() {
		
	}

	public MemberVO(Integer tid, String id, String pwd, String pwdRe, String name, String nickname, Date birth,
			String gender, String phone) {
		this.tid = tid;
		this.id = id;
		this.pwd = pwd;
		this.pwdRe = pwdRe;
		this.name = name;
		this.nickname = nickname;
		this.birth = birth;
		this.gender = gender;
		this.phone = phone;
	}

	public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getPwdRe() {
        return pwdRe;
    }

    public void setPwdRe(String pwdRe) {
        this.pwdRe = pwdRe;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getModDate() {
        return modDate;
    }

    public void setMoDate(Date modDate) {
        this.modDate = modDate;
    }
}
