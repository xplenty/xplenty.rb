module Xplenty
  class API
    # POST /<accountID>/api/clusters
    def create_cluster(cluster_info)
      cluster_info = cluster_info.inject({}) { |v, hv|
        v.merge({"cluster[#{hv.first}]" => hv.last})
      }

      request(
        :expects => 201,
        :method => :post,
        :path => "/#{account_id}/api/clusters",
        :query => cluster_info
      )
    end

    # GET /<accountID>/api/clusters/<clusterID>
    def get_cluster_info(clusterID)
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/clusters/#{clusterID}"
      )
    end

    # GET /<accountID>/api/clusters
    def clusters(options={})
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/clusters",
        :query => options
      )
    end

    # DELETE /<accountID>/api/clusters/<clusterID>
    def terminate_cluster(clusterID)
      request(
        :expects => 200,
        :method => :delete,
        :path => "/#{account_id}/api/clusters/#{clusterID}"
      )
    end

  end
end
