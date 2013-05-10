module Xplenty
  class API
    module Mock

      # stub POST /:account_id/api/jobs
      Excon.stub(:expects => 201, :method => :post, :path => %r{^/\w+/api/jobs} ) do |params|
        request_params, mock_data = parse_stub_params(params)

        params = request_params[:query]

        new_id = rand(99999)
        if get_mock_job(mock_data, new_id)
          {
            :body => {:error => 'Already exists'},
            :status => 500
          }
        else
          job_data = {
            'id' => new_id,
            'status' => "pending",
            'variables' => "New Cluster Description",
            'owner_id' => "1",
            'progress' => 0,
            'outputs_count' => 0,
            'started_at' => timestamp,
            'created_at' => timestamp,
            'updated_at' => timestamp,
            'failed_at' => nil,
            'cluster_id' => params['job[cluster_id]'],
            'package_id' => params['job[package_id]'],
            "errors" => nil,
            "url" => "https://api.xplenty.com/xplenation/api/jobs/#{new_id}",
            'runtime_in_seconds' => 0,
          }
          mock_data[:jobs] << job_data
          {
            :body   => Xplenty::API::OkJson.encode(job_data),
            :status => 201
          }
        end
      end


      # stub GET /:account_id/api/jobs
      Excon.stub(:expects => 200, :method => :get, :path => %r{^/\w+/api/jobs$} ) do |params|
        request_params, mock_data = parse_stub_params(params)
        {
          :body   => Xplenty::API::OkJson.encode(mock_data[:jobs]),
          :status => 200
        }
      end

      # stub GET /:account_id/api/jobs/:job_id
      Excon.stub(:expects => 200, :method => :get, :path => %r{^/\w+/api/jobs/([^/]+)$} ) do |params|
        request_params, mock_data = parse_stub_params(params)
        job_id, _ = request_params[:captures][:path]

        with_mock_job(mock_data, job_id) do |job_data|
          {
            :body   => Xplenty::API::OkJson.encode(job_data),
            :status => 200
          }
        end
      end

      # stub DELETE /:account_id/api/jobs/:job_id
      Excon.stub(:expects => 200, :method => :delete, :path => %r{^/\w+/api/jobs/([^/]+)$} ) do |params|
        request_params, mock_data = parse_stub_params(params)
        job_id, _ = request_params[:captures][:path]

        job = get_mock_job(mock_data, job_id)

        if job
          mock_data[:jobs].delete job
          {
            :body   => Xplenty::API::OkJson.encode(job),
            :status => 200
          }
        else
          JOB_NOT_FOUND
        end
      end

    end
  end
end
