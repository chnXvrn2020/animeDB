package com.animeDB.common.vo;

import java.util.Date;

public class CommunityPostVO extends PageVO{
    private int idx;
    private int listIdx;
    private int memberIdx;
    private String title;
    private String content;
    private int hit;
    private int thumbs;
    private int dislike;
    private String noticeYn;
    private String deleteYn;
    private Date insertDate;
    private Date updateDate;
    private Date deleteDate;
    private String locale;

    //Community list
    private String cnameKr;
    private String cnameEn;
    private String cnameJp;

    //Member
    private String nickname;
    private String userId;
    private String role;

    //Member attachment
    private String attachment;

    private int commentCnt;

    public CommunityPostVO() {

    }

    public CommunityPostVO(int listIdx) {
        this.listIdx = listIdx;
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getListIdx() {
        return listIdx;
    }

    public void setListIdx(int listIdx) {
        this.listIdx = listIdx;
    }

    public int getMemberIdx() {
        return memberIdx;
    }

    public void setMemberIdx(int memberIdx) {
        this.memberIdx = memberIdx;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public int getThumbs() {
        return thumbs;
    }

    public void setThumbs(int thumbs) {
        this.thumbs = thumbs;
    }

    public int getDislike() {
        return dislike;
    }

    public void setDislike(int dislike) {
        this.dislike = dislike;
    }

    public String getNoticeYn() {
        return noticeYn;
    }

    public void setNoticeYn(String noticeYn) {
        this.noticeYn = noticeYn;
    }

    public String getDeleteYn() {
        return deleteYn;
    }

    public void setDeleteYn(String deleteYn) {
        this.deleteYn = deleteYn;
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

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getCnameKr() {
        return cnameKr;
    }

    public void setCnameKr(String cnameKr) {
        this.cnameKr = cnameKr;
    }

    public String getCnameEn() {
        return cnameEn;
    }

    public void setCnameEn(String cnameEn) {
        this.cnameEn = cnameEn;
    }

    public String getCnameJp() {
        return cnameJp;
    }

    public void setCnameJp(String cnameJp) {
        this.cnameJp = cnameJp;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getCommentCnt() {
        return commentCnt;
    }

    public void setCommentCnt(int commentCnt) {
        this.commentCnt = commentCnt;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }
}
