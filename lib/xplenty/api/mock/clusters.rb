module Xplenty
  class API
    module Mock

      # stub POST /:account_id/api/clusters
      Excon.stub(:expects => 201, :method => :post, :path => %r{^/\w+/api/clusters$} ) do |params|
        request_params, mock_data = parse_stub_params(params)

        new_id = rand(99999)

        if get_mock_cluster(mock_data, new_id)
          {
            :body => {:error => 'Already exists'},
            :status => 500
          }
        else
          cluster_data = {
            'id' => new_id,
            'name' => "New Cluster",
            'description' => "New Cluster Description",
            'status' => "pending",
            'owner_id' => 27,
            'plan_id' => 1,
            'nodes' => 1,
            'type' => "sandbox",
            'created_at' => timestamp,
            'updated_at' => timestamp,
            'available_since' => nil,
            'terminated_at' => Time.now.to_s,
            'running_jobs_count' => 0,
            'url' => "https://api.xplenty.com/xplenation/api/clusters/167"
          }
          mock_data[:clusters] << cluster_data
          {
            :body   => Xplenty::API::OkJson.encode(cluster_data),
            :status => 201
          }
        end
      end

      # stub GET /:account_id/api/clusters
      Excon.stub(:expects => 200, :method => :get, :path => %r{^/\w+/api/clusters$} ) do |params|
        {
          :body   => File.read("#{File.dirname(__FILE__)}/cache/clusters.json"),
          :status => 200
        }
      end

      # stub DELETE /:account_id/api/clusters/:cluster_id
      Excon.stub(:expects => 200, :method => :delete, :path => %r{^/\w+/api/clusters/([^/]+)$} ) do |params|
        request_params, mock_data = parse_stub_params(params)
        cluster_id, _ = request_params[:captures][:path]

        cluster = get_mock_cluster(mock_data, cluster_id)

        if cluster
          # mock_data[:clusters].delete cluster
          {
            :body   => Xplenty::API::OkJson.encode(cluster),
            :status => 200
          }
        else
          CLUSTER_NOT_FOUND
        end
      end

      # stub GET /:account_id/api/clusters/:cluster_id
      Excon.stub(:expects => 200, :method => :get, :path => %r{^/\w+/api/clusters/([^/]+)$} ) do |params|
        request_params, mock_data = parse_stub_params(params)
        cluster_id, _ = request_params[:captures][:path]

        cluster = get_mock_cluster(mock_data, cluster_id)

        if cluster
          {
            :body   => Xplenty::API::OkJson.encode(cluster),
            :status => 200
          }
        else
          CLUSTER_NOT_FOUND
        end
      end

    end
  end
end
