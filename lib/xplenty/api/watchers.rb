module Xplenty
  class API
    # POST /_<accountID>_/api/clusters/{clusterID}/watchers
    def watch_cluster(clusterID)
      request(
        :expects => 200,
        :method => :post,
        :path => "/_#{account_id}_/api/clusters/#{clusterID}/watchers"
      )
    end

    # DELETE /_<accountID>_/api/clusters/{clusterID}/watchers
    def stop_watching_cluster(clusterID)
      request(
        :expects => 204,
        :method => :delete,
        :path => "/_#{account_id}_/api/clusters/#{clusterID}/watchers"
      )
    end

    # GET /_<accountID>_/api/clusters/{cluster_id}/watchers
    def cluster_watchers(clusterID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/_#{account_id}_/api/clusters/#{clusterID}/watchers"
      )
    end

    # POST /_<accountID>_/api/jobs/{job_id}/watchers
    def watch_job(jobID)
      request(
        :expects => 200,
        :method => :post,
        :path => "/_#{account_id}_/api/jobs/#{jobID}/watchers"
      )
    end

    # DELETE /_<accountID>_/api/jobs/{job_id}/watchers
    def stop_watching_job(jobID)
      request(
        :expects => 204,
        :method => :delete,
        :path => "/_#{account_id}_/api/jobs/#{jobID}/watchers"
      )
    end

    # GET /_<accountID>_/api/jobs/{job_id}/watchers
    def job_watchers(jobID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/_#{account_id}_/api/jobs/#{jobID}/watchers"
      )
    end
  end
end