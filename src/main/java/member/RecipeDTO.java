package member;

public class RecipeDTO {
    private int pid;
    private String pName;
    private String nation;
    private String cal;
    private String level;
    private String myPercent;
    private String step;
    private String image;


    public int getPid() {
        return pid;
    }
    
    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getCal() {
        return cal;
    }

    public void setCal(String cal) {
        this.cal = cal;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

	public String getMyPercent() {
		
		return myPercent;
	}

	public void setMyPercent(String myPercent) {
		this.myPercent = myPercent;
	}
	
	public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
  
}