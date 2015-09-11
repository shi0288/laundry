package com.mcp.myself.bean;

/**
 * Created by forest on 2015/8/25.
 */
public class Activity {
    private String activeId;
    private String activeType;
    private String activeName;
    private int num;
    private String activeDes;
    private boolean check;

    public void setCheck(boolean check) {
        this.check = check;
    }

    public boolean isCheck() {
        return check;
    }

    public void setActiveId(String activeId) {
        this.activeId = activeId;
    }

    public void setActiveType(String activeType) {
        this.activeType = activeType;
    }

    public void setActiveName(String activeName) {
        this.activeName = activeName;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public void setActiveDes(String activeDes) {
        this.activeDes = activeDes;
    }

    public String getActiveId() {
        return activeId;
    }

    public String getActiveType() {
        return activeType;
    }

    public String getActiveName() {
        return activeName;
    }

    public int getNum() {
        return num;
    }

    public String getActiveDes() {
        return activeDes;
    }
}
