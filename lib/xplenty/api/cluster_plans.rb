module Xplenty
  class API
    # GET /_<accountID>_/api/cluster_plans
    def cluster_plans
      request(
        :expects => 200,
        :method => :get,
        :path => "/_#{account_id}_/api/cluster_plans"
      )
    end
  end
end