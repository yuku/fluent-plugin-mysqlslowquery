#
# in_mysql_slow_query
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require "myslog"
require "fluent/plugin/in_tail"

module Fluent::Plugin

class MySQLSlowQueryInput < Fluent::Plugin::TailInput
  Fluent::Plugin.register_input('mysql_slow_query', self)

  def configure_parser(conf)
    @parser = MySlog.new
  end

  def search_last_use_database
    last_use_query = File.open(@path).grep(/^use /).last
    if last_use_query
      last_use_database = last_use_query.match(/^use ([^;]+)/)
      @last_use_database = last_use_database[1] if last_use_database
      return @last_use_database
    end
  end

  def receive_lines(lines)
    es = MultiEventStream.new
    @parser.divide(lines).each do |record|
      begin
        record = stringify_keys @parser.parse_record(record)
        if time = record.delete('date')
          time = time.to_i
        else
          time = Time.now.to_i
        end

        if record['db'].nil? || record['db'].empty?
          record['db'] = @last_use_database ? @last_use_database : search_last_use_database()
        end

        es.add(time, record)
      rescue
        $log.warn record, :error=>$!.to_s
        $log.debug_backtrace
      end
    end

    unless es.empty?
      begin
        router.emit_stream(@tag, es)
      rescue
      end
    end
  end

  private

  def stringify_keys(record)
    result = {}
    record.each_key do |key|
      result[key.to_s] = record[key]
    end
    result
  end
end

end
