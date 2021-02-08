package com.animeDB.util;

public class Pager {

    private int rowsPerPage; //Records to print per page
    private final int pagePerBlock = 7; //Blocks to print when paging
    private int totalPage; //total page amount
    private int firstPage; //number of first page
    private int lastPage; //number of last page
    private int prevLink; //previous page
    private int nextLink; //next page
    private int startRecord; //beginning rownum
    private int endRecord; //ending rownum
    private int listNo; //number that print on list
    private int[] pageLinks; //array that first page to last page

    public int getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(int rowsPerPage) {
        this.rowsPerPage = rowsPerPage;
    }

    public int getPagePerBlock() {
        return pagePerBlock;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getFirstPage() {
        return firstPage;
    }

    public void setFirstPage(int firstPage) {
        this.firstPage = firstPage;
    }

    public int getLastPage() {
        return lastPage;
    }

    public void setLastPage(int lastPage) {
        this.lastPage = lastPage;
    }

    public int getPrevLink() {
        return prevLink;
    }

    public void setPrevLink(int prevLink) {
        this.prevLink = prevLink;
    }

    public int getNextLink() {
        return nextLink;
    }

    public void setNextLink(int nextLink) {
        this.nextLink = nextLink;
    }

    public int getStartRecord() {
        return startRecord;
    }

    public void setStartRecord(int startRecord) {
        this.startRecord = startRecord;
    }

    public int getEndRecord() {
        return endRecord;
    }

    public void setEndRecord(int endRecord) {
        this.endRecord = endRecord;
    }

    public int getListNo() {
        return listNo;
    }

    public void setListNo(int listNo) {
        this.listNo = listNo;
    }

    public int[] getPageLinks() {
        return pageLinks;
    }

    public void setPageLinks(int[] pageLinks) {
        this.pageLinks = pageLinks;
    }

    public Pager(int totalRecord, int curPage, int rowsPerPage) {
        super();
        this.rowsPerPage = rowsPerPage;

        setPagingValue(totalRecord, curPage, rowsPerPage);
    }

    public void setPagingValue(int totalRecord, int curPage, int rowsPerPage) {
        this.totalPage = ((totalRecord % rowsPerPage) == 0)
                ? totalRecord / rowsPerPage : totalRecord / rowsPerPage + 1;
        this.firstPage = curPage >= 5 && totalPage >= 7 ? curPage - 2 : 1;
        this.lastPage = curPage >= 5 && totalPage >= 7 ? curPage + 2 : totalPage;

        pageLinks = makeArray(firstPage, lastPage);

        this.prevLink = curPage - 1;
        this.nextLink = curPage + 1;

        this.listNo = totalRecord - (curPage - 1) * rowsPerPage;
        this.startRecord = (curPage - 1) * rowsPerPage + 1;
        this.endRecord = startRecord + rowsPerPage - 1;
    }

    private int[] makeArray(int first, int last) {
        int size = last - first + 1;
        int[] ret = new int[size];
        for (int i = 0; i < size; i++) {
            ret[i] = first++;
        }
        return ret;
    }
}
