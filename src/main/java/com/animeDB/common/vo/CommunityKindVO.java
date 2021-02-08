package com.animeDB.common.vo;

import java.util.Date;

public class CommunityKindVO extends PageVO {
    private int idx;
    private String nameJp;
    private String nameKr;
    private String nameEn;
    private Date insertDate;
    private Date updateDate;
    private Date deleteDate;
    private String insertAdmin;
    private String useYn;

    //list count
    private int listCnt;

    public CommunityKindVO() {
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getNameJp() {
        return nameJp;
    }

    public void setNameJp(String nameJp) {
        this.nameJp = nameJp;
    }

    public String getNameKr() {
        return nameKr;
    }

    public void setNameKr(String nameKr) {
        this.nameKr = nameKr;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public Date getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(Date insertDate) {
        this.insertDate = insertDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }

    public String getInsertAdmin() {
        return insertAdmin;
    }

    public void setInsertAdmin(String insertAdmin) {
        this.insertAdmin = insertAdmin;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public int getListCnt() {
        return listCnt;
    }

    public void setListCnt(int listCnt) {
        this.listCnt = listCnt;
    }
}
