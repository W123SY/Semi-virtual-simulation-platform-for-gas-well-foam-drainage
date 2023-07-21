package com.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "smart")
public class Smart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private float youya;
    private float taoya;
    private float liuliang1;
    private float liuliang2;
    private float liuliang3;

    @Column(name = "create_time")
    private String createTime;




    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getYouya() {
        return youya;
    }

    public void setYouya(Integer youya) {
        this.youya = youya;
    }

    public float getTaoya() {
        return taoya;
    }

    public void setTaoya(Integer taoya) {
        this.taoya = taoya;
    }

    public float getLiuliang1() {
        return liuliang1;
    }

    public void setLiuliang1(Integer liuliang1) {
        this.liuliang1 = liuliang1;
    }

    public float getLiuliang2() {
        return liuliang2;
    }

    public void setLiuliang2(Integer liuliang2) {
        this.liuliang2 = liuliang2;
    }
    public float getLiuliang3() {
        return liuliang3;
    }

    public void setLiuliang3(Integer liuliang3) {
        this.liuliang3 = liuliang3;
    }


    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
