library(httr)
library(jsonlite)
library(dotenv)

load_dot_env(".env")
client_id <- Sys.getenv("CLIENT_ID")
client_secret <- Sys.getenv("CLIENT_SECRET")
push_url <- Sys.getenv("PUSH_URL")

token_response <- POST("https://id.twitch.tv/oauth2/token",
                       query = list(client_id = client_id,
                                    client_secret = client_secret,
                                    grant_type = "client_credentials"))
token <- content(token_response)$access_token

push_twitch_data <- function() {
  response <- GET("https://api.twitch.tv/helix/streams",
                  add_headers("Client-ID" = client_id,
                              "Authorization" = paste("Bearer", token)),
                  query = list(first = 10))
  streams <- content(response)$data
  
  payload <- lapply(streams, function(stream) {
    list(
      Timestamp = Sys.time(),
      Streamer = stream$user_name,
      Viewers = stream$viewer_count,
      Game = stream$game_name,
      StartTime = stream$started_at
    )
  })
  
  json_data <- toJSON(payload, auto_unbox = TRUE)
  POST(push_url, body = json_data, content_type("application/json"))
}

while (TRUE) {
  push_twitch_data()
  Sys.sleep(30)
}