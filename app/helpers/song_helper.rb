require 'rspotify'
RSpotify.authenticate("af667ed038f04c8cb5804570c3ca2c43", "99dcf1d0dd8544dd95344ed1f37f3c4d")
# af667ed038f04c8cb5804570c3ca2c43
# 99dcf1d0dd8544dd95344ed1f37f3c4d
module SongHelper
  def getSongsFromAPI(stringQuery)
    RSpotify::Track.search(stringQuery, limit: 10, market: 'US')
  end
end
