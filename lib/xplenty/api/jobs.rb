module Xplenty
  class API
    # GET <accountID>/api/jobs/<jobID>
    def get_job_info(jobID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/jobs/#{jobID}"
      )
    end

    # GET <accountID>/api/jobs
    def jobs(options={})
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/jobs",
        :query => options
      )
    end

    # POST /<accountID>/api/jobs
    def run_job(clusterID, packageID, args = {})
      query = args.inject({}) {|v, kv|
        v.merge(
          {
            "job[variables][#{kv.first}]" => kv.last
          })
      }
      query = query.merge(
        {
          'job[cluster_id]' => clusterID,
          'job[package_id]' => packageID
        })

      request(
        :expects => 201,
        :method => :post,
        :path => "/#{account_id}/api/jobs",
        :query => query
      )
    end

    # DELETE /<accountID>/api/jobs/<jobID>
    def terminate_job(jobID)
      request(
        :expects => 200,
        :method => :delete,
        :path => "/#{account_id}/api/jobs/#{jobID}"
      )
    end
  end
end
