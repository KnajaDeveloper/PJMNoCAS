// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.web.pjm;

import com.app2.app2t.domain.pjm.*;
import com.app2.app2t.util.AuthorizeUtil;
import flexjson.JSONSerializer;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

privileged aspect ProjectController_Custom_Controller_Json {

    @RequestMapping(value = "/saveOrUpdateProject",method = RequestMethod.POST, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.saveOrUpdateProject(
        @RequestParam(value = "projectCode", required = false) String projectCode,
        @RequestParam(value = "projectName", required = false) String projectName,
        @RequestParam(value = "projectCost", required = false) Double projectCost,
        @RequestParam(value = "dateStart", required = false) @DateTimeFormat(pattern = "dd/MM/yyyy") Date dateStart,
        @RequestParam(value = "dateEnd", required = false) @DateTimeFormat(pattern = "dd/MM/yyyy") Date dateEnd,
        @RequestParam(value = "arr_ProjectManager", required = false) String arr_ProjectManager
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            String[] arrPJM = arr_ProjectManager.split("==");
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            Project project = Project.saveOrUpdateProject(projectCode, projectName, projectCost, formatter.parse(formatter.format(dateStart)), formatter.parse(formatter.format(dateEnd)));
            ProjectManager.saveProjectManagerByProJect(project, arrPJM);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(project),headers, HttpStatus.CREATED);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByProjectCode",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.findProjectByProjectCode(
        @RequestParam(value = "projectCode", required = false) String projectCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Project> result = Project.findProjectByProjectCode(projectCode);
            return  new ResponseEntity<String>(result.size() + "", headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectSearchData",method = RequestMethod.GET, headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.findProjectSearchData(
            @RequestParam(value="StDateBegin",required=false)String StDateBegin,
            @RequestParam(value="StDateEnd",required=false)String StDateEnd,
            @RequestParam(value="FnDateBegin",required=false)String FnDateBegin,
            @RequestParam(value="FnDateEnd",required=false)String FnDateEnd,
            @RequestParam(value = "costStart", required = false) Double costStart,
            @RequestParam(value = "costEnd", required = false) Double costEnd,
            @RequestParam(value = "projectManage", required = false) String projectManage,
            @RequestParam(value = "maxResult", required = false) Integer maxResult,
            @RequestParam(value = "firstResult", required = false) Integer firstResult,
            @RequestParam(value = "moduleManager", required = false) String moduleManager)
            {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");

        try
        {
//            LOGGER.debug("MODULE++PROJECT??>>>>>>>>>>>"+moduleManager +"<>"+projectManage);
            List<Map<String,Object>> resultSearch = new ArrayList<>();
            String userName = AuthorizeUtil.getUserName();
            Map employee = emRestService.getEmployeeByUserName(userName);
            List<Project> result = Project.finProjectOfDataPagingData(StDateBegin,StDateEnd,FnDateBegin,FnDateEnd,costStart,costEnd,projectManage,maxResult,firstResult,moduleManager );
            for(Project project : result) {
                Map<String, Object> map = new HashMap<>();
                map.put("projectName", project.getProjectName());
                map.put("projectCost", project.getProjectCost());
                map.put("dateStart", project.getDateStart());
                map.put("dateEnd", project.getDateEnd());
                map.put("id", project.getId());
                map.put("projectCode", project.getProjectCode());
                map.put("inUse", ModuleProject.findModuleProjectCheckID(project.getId()));
                Boolean rolePm = ProjectManager.checkRoleProjects(project.getId(),employee.get("empCode").toString());
                map.put("rolePm",rolePm);
                resultSearch.add(map);

            }
//            LOGGER.debug("+{}{}>>>>>>>>>>>>>>>>" + resultSearch);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(resultSearch), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/projectPaggingSize", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> ProjectController.projectPaggingSize(
            @RequestParam(value="StDateBegin",required=false)String StDateBegin,
            @RequestParam(value="StDateEnd",required=false)String StDateEnd,
            @RequestParam(value="FnDateBegin",required=false)String FnDateBegin,
            @RequestParam(value="FnDateEnd",required=false)String FnDateEnd,
            @RequestParam(value = "costStart", required = false) Double costStart,
            @RequestParam(value = "costEnd", required = false) Double costEnd,
            @RequestParam(value = "projectManage", required = false) String projectManage,
            @RequestParam(value = "moduleManager", required = false) String moduleManager)
            {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try
        {
           Long result = Project.finProjectOfDataPagingSize( StDateBegin,StDateEnd,FnDateBegin,FnDateEnd,costStart,costEnd,projectManage,moduleManager);
            Map dataSendToFront = new HashMap();
            dataSendToFront.put("size",result);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(dataSendToFront), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/deleteProjects",method = RequestMethod.GET, headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.deleteProjects(
            @RequestParam(value="projectId",required=false)long projectId)
            {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try
        {
            ProjectManager.deleteProjectManager(projectId);
            List<Project> result = Project.deleteProjects(projectId);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        }
        catch (Exception e)
        {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectCheckID",method = RequestMethod.GET, headers = "Accept=application/json")
    public ResponseEntity<String> ModuleProjectController.findProjectCheckID(
            @RequestParam(value="projectId",required=false)long projectId)
            {
                HttpHeaders headers = new HttpHeaders();
                headers.add("Content-Type", "application/json;charset=UTF-8");
                try
                {
                    List<ModuleProject> result = ModuleProject.findProjectCheckID(projectId);
//                    LOGGER.debug("{[test]}:"+result);
                    return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
                }
                catch (Exception e)
                {
                    LOGGER.error(e.getMessage(), e);
                    return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }

      @RequestMapping(value = "/findProjectByProjectCode2",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.findProjectByProjectCode2(
        @RequestParam(value = "projectCode", required = false) String projectCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Project> result = Project.findProjectByProjectCode2(projectCode);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
       @RequestMapping(value = "/findproject",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.findproject(
            @RequestParam(value = "projectCode", required = false) String projectCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Project> result = Project.findproject(projectCode);
            return  new ResponseEntity<String>(result.size() + "", headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByIdProject",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.findProjectByIdProject(
        @RequestParam(value = "projectID", required = false) long projectID
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Project> dataProject = Project.findProjectByIdProject(projectID);;
            List<ProjectManager> dataProjectManager = ProjectManager.findManagerByProject(dataProject.get(0));
            List<ModuleProject> dataModuleProject = ModuleProject.findAllNameModuleByProjectCode(dataProject.get(0));
            List<List<ModuleManager>> dataModuleManager = new ArrayList<>();
            List<List<ModuleMember>> dataModuleMember = new ArrayList<>();
            for(int i = 0 ; i < dataModuleProject.size() ; i++){
                List<ModuleManager> getData = ModuleManager.findModuleManagerByModuleProject(dataModuleProject.get(i));
                dataModuleManager.add(getData);
            }
            for(int i = 0 ; i < dataModuleProject.size() ; i++){
                List<ModuleMember> getData = ModuleMember.findModuleMemberByModuleProject(dataModuleProject.get(i));
                dataModuleMember.add(getData);
            }
            Map<String,Object> result = new HashMap<>();
            result.put("Project",dataProject);
            result.put("ProjectManager",dataProjectManager);
            result.put("ModuleProject",dataModuleProject);
            result.put("ModuleManager",dataModuleManager);
            result.put("ModuleMember",dataModuleMember);
            return new ResponseEntity<String>( new JSONSerializer().exclude("*.class").deepSerialize(result) , headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/updateProjectByIdProject",method = RequestMethod.POST, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.updateProjectByIdProject(
            @RequestParam(value = "projectID", required = false) long projectID,
            @RequestParam(value = "projectCode", required = false) String projectCode,
            @RequestParam(value = "projectName", required = false) String projectName,
            @RequestParam(value = "projectCost", required = false) Double projectCost,
            @RequestParam(value = "dateStart", required = false) Date dateStart,
            @RequestParam(value = "dateEnd", required = false) Date dateEnd,
            @RequestParam(value = "arr_ProjectManager", required = false) String arr_ProjectManager,
            @RequestParam(value = "version", required = false) Integer version
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            Project pj = Project.findProject(projectID);
            if (pj.getVersion().equals(version)) {
                String[] arrPJM = arr_ProjectManager.split("==");
                Project project = Project.updateProjectByIdProject(projectID, projectCode, projectName, projectCost, dateStart, dateEnd);
                ProjectManager.deleteAllProjectManagerByProjectId(project);
                ProjectManager.saveProjectManagerByProJect(project, arrPJM);
                return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(project), headers, HttpStatus.CREATED);
            }
            else{
                return new ResponseEntity<String>(headers, HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    //------findAllProject--------------------------------------------------------------------------------------
    @RequestMapping(value = "/findAllProject", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String>ProjectController.findAllProject(){
        HttpHeaders headers=new HttpHeaders();
        headers.add("Content-Type","application/json;charset=UTF-8");
        try{
            List<Project>result=Project.findAllProject();
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result),headers,HttpStatus.OK);
        }catch(Exception e){
            LOGGER.error(e.getMessage(),e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}",headers,HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/incresePointProjectByIdProject",method = RequestMethod.POST, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> ProjectController.updateProjectByIdProject(
            @RequestParam(value = "projectId", required = false) long projectId ,
            @RequestParam(value = "increseCost", required = false) Double increseCost
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            if(increseCost > 0){
                List<Project> projectList = Project.findProjectByIdProject(projectId);
                Project project = Project.increseCostByModuleNameAndProjectId(projectId,increseCost,projectList.get(0).getProjectCost());
                return new ResponseEntity<String>((new JSONSerializer().exclude("*.class").deepSerialize(project)),headers, HttpStatus.CREATED);
            }
            else {
                List<Project> projectList = Project.findProjectByIdProject(projectId);
                Project project = Project.decreseCostByModuleNameAndProjectId(projectId,increseCost);
                return new ResponseEntity<String>((new JSONSerializer().exclude("*.class").deepSerialize(project)),headers, HttpStatus.CREATED);
            }
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByYearAndProjectId", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String>ProjectController.findProjectByYear(
            @RequestParam(value = "year", required = false) int year
    ){
        HttpHeaders headers=new HttpHeaders();
        headers.add("Content-Type","application/json;charset=UTF-8");
        try{
            List<Project> result = Project.findProjectByYearAndProjectId(year,null);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result),headers,HttpStatus.OK);
        }catch(Exception e){
            LOGGER.error(e.getMessage(),e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}",headers,HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByTextLov", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> ProjectController.findProjectByTextLov(
            @RequestParam(value = "text", required = false) String text
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Project> projectList = Project.findEmployeeByTextLov(text);
            List<Map> list = new ArrayList<>();
            for (Project pj : projectList) {
                Map map = new HashMap();
                map.put("projectCode", pj.getProjectCode());
                map.put("projectName", pj.getProjectName());
                int year = Integer.parseInt(""+pj.getDateStart().getYear())+1900;
                map.put("projectYear", year);
                map.put("projectId", pj.getId());
                list.add(map);
            }
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}



