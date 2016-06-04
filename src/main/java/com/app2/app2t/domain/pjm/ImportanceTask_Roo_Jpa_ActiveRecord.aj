// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.pjm;

import com.app2.app2t.domain.pjm.ImportanceTask;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ImportanceTask_Roo_Jpa_ActiveRecord {
    
    public static final List<String> ImportanceTask.fieldNames4OrderClauseFilter = java.util.Arrays.asList("importanceTaskCode", "importanceTaskName");
    
    public static long ImportanceTask.countImportanceTasks() {
        return entityManager().createQuery("SELECT COUNT(o) FROM ImportanceTask o", Long.class).getSingleResult();
    }
    
    public static List<ImportanceTask> ImportanceTask.findAllImportanceTasks() {
        return entityManager().createQuery("SELECT o FROM ImportanceTask o", ImportanceTask.class).getResultList();
    }
    
    public static List<ImportanceTask> ImportanceTask.findAllImportanceTasks(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM ImportanceTask o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, ImportanceTask.class).getResultList();
    }
    
    public static ImportanceTask ImportanceTask.findImportanceTask(Long id) {
        if (id == null) return null;
        return entityManager().find(ImportanceTask.class, id);
    }
    
    public static List<ImportanceTask> ImportanceTask.findImportanceTaskEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM ImportanceTask o", ImportanceTask.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<ImportanceTask> ImportanceTask.findImportanceTaskEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM ImportanceTask o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, ImportanceTask.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public ImportanceTask ImportanceTask.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        ImportanceTask merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}