module FootballRuby
  class Error < StandardError; end
  class ResponseError < Error; end
  class ApiTokenMissingError < Error; end
  class IdMissingError < Error; end
end
