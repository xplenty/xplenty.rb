## Xplenty Ruby Wrapper

[![Gem Version](https://badge.fury.io/rb/xplenty-api.png)](http://badge.fury.io/rb/xplenty-api)
[![Build Status](https://travis-ci.org/xplenty/xplenty.rb.png)](https://travis-ci.org/xplenty/xplenty.rb)

The Xplenty rb is a Ruby artifact that provides a simple wrapper for the [Xplenty REST Api](https://github.com/xplenty/xplenty-api-doc). 
To use it, create an Xplenty::API object and call its methods to access the Xplenty API.
This page describes the available Xplenty::API methods.

### Create an Xplenty::API Object

Pass your account ID and API key to the XplentyAPI constructor.
```ruby
@xplenty = Xplenty::API.new(:api_key => 'your_api_key', :account_id => 'your_account_id')
```
NOTE: You can leave out :api_key or :account_id if ENV['XPLENTY_API_KEY'] or ENV['XPLENTY_ACCOUNT_ID'] is set accordingly instead.

If you want to supply custom values for the version, scheme or host that the Xplenty::API object will use,
you can use Xplenty::API builder methods to customize these properties.
```ruby
@xplenty = Xplenty::API.new(:api_key => 'your_api_key', :account_id => 'your_account_id', :scheme => 'https', :host => 'api.xplenty.com')
@xplenty = Xplenty::API.new(:api_key => 'your_api_key', :account_id => 'your_account_id', :headers => { 'User-Agent' => 'your user agent' })
@xplenty = Xplenty::API.new(:api_key => 'your_api_key', :account_id => 'your_account_id', :version => 1)
```
### List the Cluster Plans

A cluster plan is a definition of a cluster type, which includes the number of nodes in the cluster and its pricing. Cluster plan details can be viewed in the Xplenty web application.
After you've determined which cluster plan is appropriate for your needs, use this method to retrieve the cluster plan ID. The cluster plan ID can then be used when creating a new cluster.
```ruby
@xplenty.cluster_plans
```
### Create a Cluster

This method creates a new cluster. A cluster is a group of machines ("nodes") allocated to your account. The number of nodes in the cluster is determined by the "plan_id" value that you supply to the call. While the cluster is active, only your account's users can run jobs on the cluster.
You will need to provide an active cluster when starting a new job. Save the cluster ID value returned in the response "id" field. You will use the value to refer to this cluster in subsequent API calls.
```ruby
@xplenty.create_cluster(:nodes => 1, :type => "sandbox")
```
### List All Clusters

This method returns the list of clusters that were created by users in your account.
You can use this information to monitor and display your clusters and their statuses.

```ruby
@xplenty.clusters # return all clusters
```
XplentyAPI.listClusters() is shorthand for XplentyAPI.listClusters(new Properties()), which returns all clusters with no filtering.
You can also pass property parameters which filter the clusters according to their status, and determine the order in which they'll be sorted.
Only clusters which have the status passed in the PARAMETER_STATUS property will be returned, sorted according to the field passed in PARAMETER_SORT,
in ascending or descending order according to the PARAMETER_DIRECTION property.

```ruby
@xplenty.clusters(:status => 'terminated')
@xplenty.clusters(:sort => 'created', :direction => 'desc')
```
### Get Cluster Information

This method returns the details of the cluster with the given ID.
```ruby
@xplenty.get_cluster_info(1792)
```
### Terminate a Cluster

This method deactivates the given cluster, releasing its resources and terminating its runtime period. Use this method when all of the cluster's jobs are completed and it's no longer needed. The method returns the given cluster's details, including a status of "pending_terminate".
```ruby
@xplenty.terminate_cluster(1792)
```
### Run a Job

This method creates a new job and triggers it to run. The job performs the series of data processing tasks that are defined in the job's package. Unless the job encounters an error or is terminated by the user, it will run until it completes its tasks on all of the input data. Save the job ID value returned in the response "id" field. You will use the value to refer to this job in subsequent API calls.
```ruby
@xplenty.run_job(1792, 902, {:first_arg => 'Argument 1'})
```
### List All Jobs

This method returns information for all the jobs that have been created under your account.
```ruby
@xplenty.jobs
```
XplentyAPI.listJobs() is shorthand for XplentyAPI.listJobs(new Properties()), which returns all jobs with no filtering.
You can also pass property parameters which filter the jobs according to their status, and determine the order in which they'll be sorted.
Only jobs which have the status passed in the PARAMETER_STATUS property will be returned, sorted according to the field passed in PARAMETER_SORT,
in ascending or descending order according to the PARAMETER_DIRECTION property.
```ruby
@xplenty.jobs(:status => 'idle')
@xplenty.jobs(:status => 'completed', :sort => 'created_at', :direction => 'asc')
```

### Get Job Information

This method retrieves information for a job, according to the given job ID.
```ruby
@xplenty.get_job_info(9032)
```
### Terminate a Job

This method terminates an active job. Usually it's unnecessary to request to terminate a job, because normally the job will end when its tasks are completed. You may want to actively terminate a job if you need its cluster resources for a more urgent job, or if the job is taking too long to complete.
```ruby
@xplenty.terminate_job(9032)
```
### Watch Cluster

You can watch a cluster that you or others have created. If you'r watching a cluster, you'll receive notifications (email messages or web notifications) on important updates.

This method adds the calling user as a watcher of the specifeid cluster.
```ruby
@xplenty.watch_cluster(1792)
```
### Stop Watching Cluster

This method removes the calling user from the watcher list of the specified cluster.
```ruby
@xplenty.stop_watching_cluster(1792)
```
### Get Cluster Watchers

This call retrieves the list of users watching the specified cluster.
```ruby
@xplenty.cluster_watchers(1792)
```
### Watch Job

You can watch a job that you or others have executed. If you'r watching a job, you'll receive notifications (email messages or web notifications) on important updates.

This method adds the calling user as a watcher of the specifeid job.
```ruby
@xplenty.watch_job(9032)
```
### Stop Watching Job

This method removes the calling user from the watcher list of the specified job.
```ruby
@xplenty.stop_watching_job(9032)
```
### Get Job Watchers

This call retrieves the list of users watching the specified job.
```ruby
@xplenty.job_watchers(9032)
```
## License
Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).