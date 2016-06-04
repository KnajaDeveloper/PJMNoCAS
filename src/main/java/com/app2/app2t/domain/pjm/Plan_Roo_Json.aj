// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.pjm;

import com.app2.app2t.domain.pjm.Plan;
import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

privileged aspect Plan_Roo_Json {
    
    public String Plan.toJson() {
        return new JSONSerializer()
        .exclude("*.class").serialize(this);
    }
    
    public String Plan.toJson(String[] fields) {
        return new JSONSerializer()
        .include(fields).exclude("*.class").serialize(this);
    }
    
    public static Plan Plan.fromJsonToPlan(String json) {
        return new JSONDeserializer<Plan>()
        .use(null, Plan.class).deserialize(json);
    }
    
    public static String Plan.toJsonArray(Collection<Plan> collection) {
        return new JSONSerializer()
        .exclude("*.class").serialize(collection);
    }
    
    public static String Plan.toJsonArray(Collection<Plan> collection, String[] fields) {
        return new JSONSerializer()
        .include(fields).exclude("*.class").serialize(collection);
    }
    
    public static Collection<Plan> Plan.fromJsonArrayToPlans(String json) {
        return new JSONDeserializer<List<Plan>>()
        .use("values", Plan.class).deserialize(json);
    }
    
}