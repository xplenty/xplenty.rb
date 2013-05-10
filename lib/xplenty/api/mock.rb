require 'xplenty/api/mock/clusters'
require 'xplenty/api/mock/jobs'

module Xplenty
  class API
    module Mock

      CLUSTER_NOT_FOUND  = { :body => 'Cluster not found.',   :status => 404 }
      JOB_NOT_FOUND = { :body => 'Job not found.',  :status => 404 }

      @mock_data = Hash.new do |hash, key|
        hash[key] = {
          :clusters           => [],
          :jobs             => [],
          :watchers      => {},
        }
      end

      def self.get_mock_cluster(mock_data, cluster_id)
        @clusters ||= begin
          data = File.read("#{File.dirname(__FILE__)}/mock/cache/clusters.json")
          Xplenty::API::OkJson.decode(data)
        end
        mock_data[:clusters] = @clusters

        mock_data[:clusters].detect {|cluster_data| cluster_data['id'].to_s == cluster_id.to_s}
      end

      def self.get_mock_job(mock_data, job_id)
        @jobs ||= begin
          data = File.read("#{File.dirname(__FILE__)}/mock/cache/jobs.json")
          Xplenty::API::OkJson.decode(data)
        end
        mock_data[:jobs] = @jobs

        mock_data[:jobs].detect {|job_data| job_data['id'].to_s == job_id.to_s}
      end

      def self.parse_stub_params(params)
        mock_data = nil

        if params[:headers].has_key?('Authorization')
          api_key = Base64.decode64(params[:headers]['Authorization']).split(':').last

          parsed = params.dup
          begin # try to JSON decode
            parsed[:body] &&= Xplenty::API::OkJson.decode(parsed[:body])
          rescue # else leave as is
          end
          mock_data = @mock_data[api_key]
        end

        [parsed, mock_data]
      end

      def self.with_mock_cluster(mock_data, cluster_id, &block)
        if cluster_data = get_mock_cluster(mock_data, cluster_id)
          yield(cluster_data)
        else
          CLUSTER_NOT_FOUND
        end
      end

      def self.with_mock_job(mock_data, job_id, &block)
        if job_data = get_mock_job(mock_data, job_id)
          yield(job_data)
        else
          JOB_NOT_FOUND
        end
      end

      def self.with_mock_clusters(mock_data, &block)
        @clusters ||= begin
          data = File.read("#{File.dirname(__FILE__)}/mock/cache/clusters.json")
          Xplenty::API::OkJson.decode(data)
        end
        mock_data[:clusters] = @clusters
        yield(mock_data)
      end

      def self.timestamp
        Time.now.strftime("%G/%m/%d %H:%M:%S %z")
      end

    end
  end
end
