### Enjeux
We have three containers 
api-Service is public therefore anyone can communicate with it
etl-Service and embedding-a are private 

To communicate with a private service you need access to it


# instructions
##### iam policy 
- Go to IAM board
- Create a service account
- Name it api-comms-embbeding-service
- Create a service account
- Name it etl-comms-embbeding-service

##### cloud run

- Click on your embedding-ai service from the list.
- On the right-hand side of the screen, you will see an information panel. Click on the Security or Permissions tab. (If you don't see it, click Show Info Panel in the top right corner).
- Click + Add Principal.
- In the New principals field, paste the full email address of the first service account (e.g., api-services-sa@your-project.iam.gserviceaccount.com).
- In the Select a role dropdown, search for and select Cloud Run Invoker.
- Click Save.
- Click Add Principal again and repeat this for etl-services-sa.

