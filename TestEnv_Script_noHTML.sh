at now + 3 mins
echo "\nHI! Starting postman_collection\n"
cd GoogleDrive\(christian.catelli@kineton.it\)/Sky/Automation_IT_CI_CD_WSC/Repository/PostmanCollection_AutomationAPI/
newman run Automation.postman_collection.json -e Test.postman_environment.json -d Test.data_file.json && exit