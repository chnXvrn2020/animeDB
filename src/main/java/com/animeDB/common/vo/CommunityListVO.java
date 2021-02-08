package com.animeDB.common.vo;

import java.util.Date;

public class CommunityListVO extends PageVO{
    private int idx;
    private int kindIdx;
    private String cnameKr;
    private String cnameJp;
    private String cnameEn;
    private String insertAdmin;
    private Date insertDate;
    private Date updateDate;
    private Date deleteDate;
    private String useYn;

    private String kindKr;
    private String kindEn;
    private String kindJp;

    private int postCnt;

    public CommunityListVO() {

    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getKindIdx() {
        return kindIdx;
    }

    public void setKindIdx(int kindIdx) {
        this.kindIdx = kindIdx;
    }

    public String getCnameKr() {
        return cnameKr;
    }

    public void setCnameKr(String cnameKr) {
        this.cnameKr = cnameKr;
    }

    public String getCnameJp() {
        return cnameJp;
    }

    public void setCnameJp(String cnameJp) {
        this.cnameJp = cnameJp;
    }

    public String getCnameEn() {
        return cnameEn;
    }

    public void setCnameEn(String cnameEn) {
        this.cnameEn = cnameEn;
    }

    public String getInsertAdmin() {
        return insertAdmin;
    }

    public void setInsertAdmin(String insertAdmin) {
        this.insertAdmin = insertAdmin;
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

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getKindKr() {
        return kindKr;
    }

    public void setKindKr(String kindKr) {
        this.kindKr = kindKr;
    }

    public String getKindEn() {
        return kindEn;
    }

    public void setKindEn(String kindEn) {
        this.kindEn = kindEn;
    }

    public String getKindJp() {
        return kindJp;
    }

    public void setKindJp(String kindJp) {
        this.kindJp = kindJp;
    }

    public int getPostCnt() {
        return postCnt;
    }

    public void setPostCnt(int postCnt) {
        this.postCnt = postCnt;
    }
}
