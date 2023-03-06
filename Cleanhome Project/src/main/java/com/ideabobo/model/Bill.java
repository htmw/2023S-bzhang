package com.ideabobo.model;

import java.io.Serializable;

public class Bill implements Serializable {
    private Integer id;

    private String gids;

    private String user;

    private String uid;

    private String shop;

    private String ndate;

    private String total;

    private String gnames;

    private String sid;

    private String tel;

    private String address;

    private String note;

    private String statecn;

    private String pnote;

    private String pf;

    private String shstatecn;

    private String shnote;

    private String shtype;

    private String fhnote;

    private String kid;

    private String ktitle;

    private String kcode;

    private Integer qid;

    private String qusername;

    private String qtel;

    private String bgcounts;

    private String way;

    private String ydate;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGids() {
        return gids;
    }

    public void setGids(String gids) {
        this.gids = gids == null ? null : gids.trim();
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user == null ? null : user.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public String getShop() {
        return shop;
    }

    public void setShop(String shop) {
        this.shop = shop == null ? null : shop.trim();
    }

    public String getNdate() {
        return ndate;
    }

    public void setNdate(String ndate) {
        this.ndate = ndate == null ? null : ndate.trim();
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total == null ? null : total.trim();
    }

    public String getGnames() {
        return gnames;
    }

    public void setGnames(String gnames) {
        this.gnames = gnames == null ? null : gnames.trim();
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid == null ? null : sid.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public String getStatecn() {
        return statecn;
    }

    public void setStatecn(String statecn) {
        this.statecn = statecn == null ? null : statecn.trim();
    }

    public String getPnote() {
        return pnote;
    }

    public void setPnote(String pnote) {
        this.pnote = pnote == null ? null : pnote.trim();
    }

    public String getPf() {
        return pf;
    }

    public void setPf(String pf) {
        this.pf = pf == null ? null : pf.trim();
    }

    public String getShstatecn() {
        return shstatecn;
    }

    public void setShstatecn(String shstatecn) {
        this.shstatecn = shstatecn == null ? null : shstatecn.trim();
    }

    public String getShnote() {
        return shnote;
    }

    public void setShnote(String shnote) {
        this.shnote = shnote == null ? null : shnote.trim();
    }

    public String getShtype() {
        return shtype;
    }

    public void setShtype(String shtype) {
        this.shtype = shtype == null ? null : shtype.trim();
    }

    public String getFhnote() {
        return fhnote;
    }

    public void setFhnote(String fhnote) {
        this.fhnote = fhnote == null ? null : fhnote.trim();
    }

    public String getKid() {
        return kid;
    }

    public void setKid(String kid) {
        this.kid = kid == null ? null : kid.trim();
    }

    public String getKtitle() {
        return ktitle;
    }

    public void setKtitle(String ktitle) {
        this.ktitle = ktitle == null ? null : ktitle.trim();
    }

    public String getKcode() {
        return kcode;
    }

    public void setKcode(String kcode) {
        this.kcode = kcode == null ? null : kcode.trim();
    }

    public Integer getQid() {
        return qid;
    }

    public void setQid(Integer qid) {
        this.qid = qid;
    }

    public String getQusername() {
        return qusername;
    }

    public void setQusername(String qusername) {
        this.qusername = qusername == null ? null : qusername.trim();
    }

    public String getQtel() {
        return qtel;
    }

    public void setQtel(String qtel) {
        this.qtel = qtel == null ? null : qtel.trim();
    }

    public String getBgcounts() {
        return bgcounts;
    }

    public void setBgcounts(String bgcounts) {
        this.bgcounts = bgcounts == null ? null : bgcounts.trim();
    }

    public String getWay() {
        return way;
    }

    public void setWay(String way) {
        this.way = way == null ? null : way.trim();
    }

    public String getYdate() {
        return ydate;
    }

    public void setYdate(String ydate) {
        this.ydate = ydate == null ? null : ydate.trim();
    }
}