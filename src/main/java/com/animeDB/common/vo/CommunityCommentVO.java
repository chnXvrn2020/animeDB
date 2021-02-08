package com.animeDB.common.vo;

import java.util.Date;

public class CommunityCommentVO extends PageVO {
    private int idx;
    private int postIdx;
    private int parentIdx;
    private int memberIdx;
    private String commentContent;
    private String locale;
    private Date insertDate;
    private Date updateDate;
    private Date deleteDate;
    private String deleteYn;
    private int depth;
    private String parentMember;

    //member
    private String userId;
    private String nickname;
    private String role;

    //attachment
    private String memberAttachment;
    private String commentAttachment;

    public CommunityCommentVO() {

    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getPostIdx() {
        return postIdx;
    }

    public void setPostIdx(int postIdx) {
        this.postIdx = postIdx;
    }

    public int getParentIdx() {
        return parentIdx;
    }

    public void setParentIdx(int parentIdx) {
        this.parentIdx = parentIdx;
    }

    public int getMemberIdx() {
        return memberIdx;
    }

    public void setMemberIdx(int memberIdx) {
        this.memberIdx = memberIdx;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
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

    public String getDeleteYn() {
        return deleteYn;
    }

    public void setDeleteYn(String deleteYn) {
        this.deleteYn = deleteYn;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getMemberAttachment() {
        return memberAttachment;
    }

    public void setMemberAttachment(String memberAttachment) {
        this.memberAttachment = memberAttachment;
    }

    public String getCommentAttachment() {
        return commentAttachment;
    }

    public void setCommentAttachment(String commentAttachment) {
        this.commentAttachment = commentAttachment;
    }

    public String getParentMember() {
        return parentMember;
    }

    public void setParentMember(String parentMember) {
        this.parentMember = parentMember;
    }
}
