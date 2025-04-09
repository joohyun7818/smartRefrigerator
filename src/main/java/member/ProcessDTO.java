package member;

public class ProcessDTO {
    private int rpid;
    private int cookNum;
    private String step;
    
    public ProcessDTO() {
    	this.rpid = 0;
        this.cookNum = 0;
        this.step = "";
    }

    public ProcessDTO(int rpid, int cookNum, String step) {
        this.rpid = rpid;
        this.cookNum = cookNum;
        this.step = step;
    }

    public int getRpid() {
        return rpid;
    }

    public void setRpid(int rpid) {
        this.rpid = rpid;
    }

    public int getCookNum() {
        return cookNum;
    }

    public void setCookNum(int cookNum) {
        this.cookNum = cookNum;
    }

    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    @Override
    public String toString() {
        return "RecipeProcessDTO{" +
                "rpid=" + rpid +
                ", cookNum=" + cookNum +
                ", step='" + step + '\'' +
                '}';
    }
}

