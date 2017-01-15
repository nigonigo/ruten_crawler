library(rvest)
library(stringr)
library(curl)
library(httr)
library(XML)
library(xml2)

URL_lists = data.frame()

for(i in 1:19){
  
  url <- 'http://class.ruten.com.tw/category/sub00.php?c=00110022&p='
  
  URL <- paste0(url,i)
  
  URL_list <- read_html(URL) %>% html_nodes("a.item-name-anchor") %>% html_attr('href')
  
  URL_lists <- append(URL_lists,URL_list) #%>% as.data.frame(., as.data.frame(., stringsAsFactors = F))
  
  #Sys.sleep(runif(1,2,4))
}  

URL_lists = as.character(URL_lists)

#cookies = httr::set_cookies("URL_list[i]" , cookie = "_ts_id=34033506320B3F073001")
#uagent = httr::user_agent("Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Mobile Safari/537.36")

rutenCrawler <- function(ruten_url_list){
  
  webHtml <- GET((URL_lists[i]),add_headers('user-agent' = 'uagent'))
  
  CMTitle <- read_html(webHtml) %>%
    
    html_nodes(".item-title") %>% 
    
    html_text()
  
  CMTime <- read_html(webHtml) %>% 
    
    html_nodes(".upload-time") %>%
    
    html_text() %>% 
    
    str_sub(start = 7 ,end = 25) 
  
    #%>% as.POSIXct()
    
  CMPrice <- read_html(webHtml) %>% 
      
    html_nodes(".rt-text-xx-large") %>% 
      
    html_text()
  
  CMSole <- read_html(webHtml) %>% 
    
    html_nodes(".rt-text-x-large") %>% 
      
    html_text() %>% .[4]
    
  CMRemainig <- read_html(webHtml) %>% 
    
    html_nodes(".rt-text-x-large") %>% 
    
    html_text() %>% .[3]
    
  CMSellerProducts <- read_html(webHtml) %>% 
    
    html_nodes(".rt-text-x-large") %>% 
    
    html_text() %>% .[2]
    
  CMSellerEvaluation <- read_html(webHtml) %>% 
    
    html_nodes(".rt-text-x-large") %>% 
    
    html_text() %>% .[1]
    
    #CMSellerName <- read_html(webHtml) %>% html_nodes(".seller-disc") %>% html_text() %>% .[1]
    #CMPurchases = read_html(webHtml) %>% htncol = 2,byrow = Fml_nodes("span.count") %>% html_text() %>% .[2]
    
  data.frame(CMTitle,CMTime,CMPrice,CMSole,CMRemainig,CMSellerProducts,CMSellerEvaluation)
}
  
  for(i in 1:length(URL_lists)){
  
    if(i == 1){
    
      finalData <- rutenCrawler(i)
    
      }else{
    
        finalData <- rbind(finalData,rutenCrawler(i))
    }
    
}

#Sys.sleep(runif(1,2,5))

