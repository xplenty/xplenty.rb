module Xplenty
  class API
    # GET /<accountID>/api/cluster_plans
    def cluster_plans
      request(
        :expects => 200,
        :method => :get,
        :path => "/#{account_id}/api/cluster_plans"
      )
    end
  end
end