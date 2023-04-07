package test;

import java.util.ArrayList;
import java.util.List;
import org.json.*;
import com.opencsv.CSVWriter;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.eclipse.jgit.lib.Repository;
import org.refactoringminer.api.*;
import org.refactoringminer.rm1.GitHistoryRefactoringMinerImpl;
import org.refactoringminer.util.*;

public class new {

    public static void main(String[] args) throws Exception {

        String repoUrl = "https://github.com/apache/cassandra.git";

        int[] prs = { 2126, 2149, 2143, 1734, 1642, 1696, 1663, 64, 473, 345, 174, 127, 129, 210, 95, 1423 };

        // detectWithPullRequest(repoUrl, 1979);

        // for (int i = 0; i < pullRequests.length; i++) {
        // Boolean status = detectWithPullRequest(pullRequests[i]);
        // if (status == false) {
        // continue;
        // }

        // if ((i > 0) && (i % 10 == 0)) {
        // Thread.sleep(300000);
        // }

        // if (pullRequests.length == (i + 1)) {
        // for (int j = 0; j < commits.length; j++) {
        // detectWithCommit(commits[j]);
        // }
        // }
        // }

        // for (int j = 0; j < prs.length; j++) {
        // detectWithPullRequest(repoUrl, prs[j]);
        // }

        String[] data = {};
        writeToCSV(data);
    }

    public static Boolean detectWithPullRequest(String repoUrl, int pullRequest) {

        try {
            GitHistoryRefactoringMiner miner = new GitHistoryRefactoringMinerImpl();

            // int pullRequest = 1428;
            miner.detectAtPullRequest(repoUrl, pullRequest,
                    new RefactoringHandler() {
                        @Override
                        public void handle(String commitId, List<Refactoring> refactorings) {
                            List<String> _excludedRefactorings = new ArrayList<String>();
                            _excludedRefactorings.add("Rename Method");
                            _excludedRefactorings.add("Rename Class");
                            _excludedRefactorings.add("Rename Variable");
                            _excludedRefactorings.add("Rename Parameter");
                            _excludedRefactorings.add("Rename Attribute");
                            _excludedRefactorings.add("Change Package");
                            _excludedRefactorings.add("Move Class");

                            ArrayList<String> excludedRefactorings = new ArrayList<String>();
                            excludedRefactorings.addAll(_excludedRefactorings);

                            System.out.println("Refactorings extraction at " + commitId);
                            getRefactorings(excludedRefactorings, refactorings, commitId);
                            System.out.println("Refactorings extraction completed " + commitId);
                        }
                    }, 10);
            return true;
        } catch (Exception e) {
            System.out.println("Error occured on PR: " + pullRequest);
            return false;
        }

    }

    public static void detectWithCommit(String repoUrl, String commitId) {
        try {
            GitService gitService = new GitServiceImpl();
            GitHistoryRefactoringMiner miner = new GitHistoryRefactoringMinerImpl();
            Repository repo = gitService.cloneIfNotExists(
                    "tmp/cassandra", repoUrl);

            // String commitId = "68f6d8263d8c795722805f0e4d6939e7a8b9ed48";

            miner.detectAtCommit(repo, commitId, new RefactoringHandler() {
                @Override
                public void handle(String commitId, List<Refactoring> refactorings) {

                    List<String> _excludedRefactorings = new ArrayList<String>();
                    _excludedRefactorings.add("Rename Method");
                    _excludedRefactorings.add("Rename Class");
                    _excludedRefactorings.add("Rename Variable");
                    _excludedRefactorings.add("Rename Parameter");
                    _excludedRefactorings.add("Rename Attribute");
                    _excludedRefactorings.add("Change Package");
                    _excludedRefactorings.add("Move Class");

                    ArrayList<String> excludedRefactorings = new ArrayList<String>();
                    excludedRefactorings.addAll(_excludedRefactorings);

                    System.out.println("Refactorings extraction at " + commitId);
                    getRefactorings(excludedRefactorings, refactorings, commitId);
                    System.out.println("Refactorings extraction completed " + commitId);
                }
            });
        } catch (Exception e) {
            System.out.println("Error occured on commit: " + commitId);
        }

    }

    public static void getRefactorings(ArrayList<String> excludedRefactorings, List<Refactoring> refactorings,
            String commitId) {
        for (Refactoring ref : refactorings) {

            String type = "";
            String filePath = "";
            int startLine = 0;
            int endLine = 0;
            String codeElement = "";
            String codeElementType = "";

            JSONObject refactoringObj = new JSONObject(ref.toJSON());
            type = refactoringObj.getString("type");

            System.out.println("refactoring name : " + type);

            JSONArray otherProps = refactoringObj.getJSONArray("rightSideLocations");
            // System.out.println(otherProps);

            for (int i = 0; i < otherProps.length(); i++) {
                // ArrayList<Object> otherData = new ArrayList<Object>();

                try {
                    JSONObject obj = otherProps.getJSONObject(i);
                    filePath = obj.getString("filePath");
                    startLine = obj.getInt("startLine");
                    endLine = obj.getInt("endLine");
                    codeElement = obj.getString("codeElement");
                    codeElementType = obj.getString("codeElementType");

                } catch (JSONException e) {
                    System.out.println("Error here...");
                    codeElement = " ";
                } finally {

                    String[] otherData = { commitId, type, filePath, String.valueOf(startLine),
                            String.valueOf(endLine), codeElementType, codeElement };
                    try {

                        writeToCSV(otherData);

                    } catch (IOException e) {

                        System.out.println("Could not write: " + type);
                    }

                }

            }

        }
    }

    public static void writeToCSV(String[] csvData) throws IOException {

        File csvFile = new File("test.csv");
        FileWriter output = new FileWriter(csvFile, true);
        CSVWriter writer = new CSVWriter(output);

        String[] headers = { "Change Attribute Type",
                "Change Variable Type",
                "Add Parameter",
                "Extract Method",
                "Localize Parameter",
                "Remove Parameter Modifier",
                "Change Return Type",
                "Extract Attribute",
                "Inline Method",
                "Remove Parameter",
                "Extract Variable",
                "Add Variable Modifier",
                "Inline Variable",
                "Refactoring Type",
                "Remove Attribute Modifier",
                "Extract Superclass",
                "Move Attribute",
                "Change Attribute Access Modifier",
                "Add Attribute Modifier",
                "Pull Up Attribute",
                "Pull Up Method",
                "Remove Thrown Exception Type",
                "Move Method",
                "Change Parameter Type",
                "Modify Attribute Annotation",
                "Add Method Annotation",
                "Change Method Access Modifier",
                "Remove Class Modifier",
                "Remove Method Modifier",
                "Add Class Modifier",
                "Replace Loop With Pipeline",
                "Add Method Modifier",
                "Extract And Move Method",
                "Add Class Annotation",
                "Change Type Declaration Kind",
                "Parameterize Variable",
                "Encapsulate Attribute",
                "Replace Attribute With Variable",
                "Move And Inline Method",
                "Modify Parameter Annotation",
                "Remove Method Annotation",
                "Modify Method Annotation",
                "Remove Variable Modifier",
                "Replace Anonymous With Lambda",
                "Change Class Access Modifier",
                "Extract Interface",
                "Add Parameter Modifier",
                "Replace Variable With Attribute",
                "Modify Class Annotation",
                "Extract Class",
                "Add Thrown Exception Type",
                "Push Down Attribute",
                "Add Attribute Annotation",
                "Move And Rename Method",
                "Remove Attribute Annotation",
                "Replace Pipeline With Loop",
                "Move And Rename Attribute",
                "Remove Class Annotation",
                "Extract Subclass",
                "Push Down Method",
                "Merge Parameter",
                "Merge Variable",
                "Split Parameter",
                "Parameterize Attribute",
                "Move And Rename Class",
                "Merge Class",
                "Remove Variable Annotation",
                "Reorder Parameter",
                "Change Thrown Exception Type" };

        writer.writeNext(headers);

        // writer.writeNext(csvData);

        writer.close();

    }

}