class MySQLSlowQueryInput < Fluent::TailInput
  Fluent::Plugin.register_input('mysql_slow_query', self)

  def configure_parser(conf)
    @_time = Time.new.to_i
    @_record = {}
  end

  def parse_line(line)
    if line.start_with?("#")
      if line[2, 5] == "Time:"
        remain = line[7..-1].strip
        @_time = Time.strptime(remain, '%y%m%d %H:%M:%S').to_i
      elsif line[2, 10] == "User@Host:"
        remain = line[12..-1].split("@").map{|s| s.strip}
        @_record["user"] = remain[0]
        @_record["host"] = remain[1]
      elsif line[2, 11] == "Query_time:"
        sl = line.split
        @_record["query_time"] = sl[2].to_f
        @_record["lock_time"] = sl[4].to_f
        @_record["rows_sent"] = sl[6].to_i
        @_record["rows_examined"] = sl[8].to_i
      end
    elsif not line.upcase.start_with?('USE') and not line.upcase.start_with?('SET')
      @_record["sql"] = line
      n_record = @_record.clone
      @_record = {}
      return @_time, n_record
    end
    return nil, nil
  end
end
