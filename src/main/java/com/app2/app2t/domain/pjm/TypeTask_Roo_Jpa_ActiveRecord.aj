// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.pjm;

import com.app2.app2t.domain.pjm.TypeTask;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

privileged aspect TypeTask_Roo_Jpa_ActiveRecord {
    
    public static final List<String> TypeTask.fieldNames4OrderClauseFilter = java.util.Arrays.asList("typeTaskCode", "typeTaskName");
    
    public static long TypeTask.countTypeTasks() {
        return entityManager().createQuery("SELECT COUNT(o) FROM TypeTask o", Long.class).getSingleResult();
    }
    
    public static List<TypeTask> TypeTask.findAllTypeTasks() {
        return entityManager().createQuery("SELECT o FROM TypeTask o", TypeTask.class).getResultList();
    }
    
    public static List<TypeTask> TypeTask.findAllTypeTasks(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM TypeTask o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, TypeTask.class).getResultList();
    }
    
    public static TypeTask TypeTask.findTypeTask(Long id) {
        if (id == null) return null;
        return entityManager().find(TypeTask.class, id);
    }
    
    public static List<TypeTask> TypeTask.findTypeTaskEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM TypeTask o", TypeTask.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<TypeTask> TypeTask.findTypeTaskEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM TypeTask o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, TypeTask.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public TypeTask TypeTask.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        TypeTask merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}