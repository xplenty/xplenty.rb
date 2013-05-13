module Xplenty
  class API
    # POST /<accountID>/api/clusters/{clusterID}/watchers
    def watch_cluster(clusterID)
      request(
        :expects => 200,
        :method => :post,
        :path => "/#{account_id}/api/clusters/#{clusterID}/watchers"
      )
    end

    # DELETE /<accountID>/api/clusters/{clusterID}/watchers
    def stop_watching_cluster(clusterID)
      request(
        :expects => 204,
        :method => :delete,
        :path => "/#{account_id}/api/clusters/#{clusterID}/watchers"
      )
    end

    # GET /<accountID>/api/clusters/{cluster_id}/watchers
    def cluster_watchers(clusterID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/clusters/#{clusterID}/watchers"
      )
    end

    # POST /<accountID>/api/jobs/{job_id}/watchers
    def watch_job(jobID)
      request(
        :expects => 200,
        :method => :post,
        :path => "/#{account_id}/api/jobs/#{jobID}/watchers"
      )
    end

    # DELETE /<accountID>/api/jobs/{job_id}/watchers
    def stop_watching_job(jobID)
      request(
        :expects => 204,
        :method => :delete,
        :path => "/#{account_id}/api/jobs/#{jobID}/watchers"
      )
    end

    # GET /<accountID>/api/jobs/{job_id}/watchers
    def job_watchers(jobID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/jobs/#{jobID}/watchers"
      )
    end
  end
end