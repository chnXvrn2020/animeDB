package com.animeDB.common.vo;

import java.util.Date;

public class MemberAttachmentVO {
    private int idx;
    private int userIdx;
    private String attachment;
    private String attachmentOrg;
    private String useYn;
    private Date insertDate;

    public MemberAttachmentVO() {}

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(int userIdx) {
        this.userIdx = userIdx;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public String getAttachmentOrg() {
        return attachmentOrg;
    }

    public void setAttachmentOrg(String attachmentOrg) {
        this.attachmentOrg = attachmentOrg;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public Date getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(Date insertDate) {
        this.insertDate = insertDate;
    }
}
