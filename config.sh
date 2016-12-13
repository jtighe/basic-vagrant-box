first_name='your_first_name'
last_name='your_last_name'
email_address='your_email_address'

declare -a Git_Repo_List
declare -A Git_Repo_Details

# Be sure to copy your PRIATE key file to project root
# Add other Git servers as necessary
Git_Repo_List[0]='github.com'
Git_Repo_Details['github.com','user_name']='your_github_user_name'
Git_Repo_Details['github.com','private_key_file_name']='github_private_key_file_name'

Git_Repo_List[1]='bitbucket.com'
Git_Repo_Details['bitbucket.com','user_name']='your_bitbucket_user_name'
Git_Repo_Details['bitbucket.com','private_key_file_name']='bitbucket_private_key_file_name'