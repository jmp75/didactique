library(plotly)

sd <- highlight_key(txhousing, ~city, "Select a city")

base <- plot_ly(sd, color = I("black"), height = 400) %>%
  group_by(city)

p1 <- base %>%
  summarise(miss = sum(is.na(median))) %>%
  filter(miss > 0) %>%
  add_markers(x = ~miss, y = ~forcats::fct_reorder(city, miss), hoverinfo = "x+y") %>%
  layout(
    barmode = "overlay",
    xaxis = list(title = "Number of months missing"),
    yaxis = list(title = "")
  ) 

p2 <- base %>%
  add_lines(x = ~date, y = ~median, alpha = 0.3) %>%
  layout(xaxis = list(title = ""))

subplot(p1, p2, titleX = TRUE, widths = c(0.3, 0.7)) %>% 
  hide_legend() %>%
  highlight(dynamic = TRUE, selectize = TRUE)


######################

library(plotly)
p <- ggplot(txhousing) + geom_line(aes(date, median, group = city))
ggplotly(p)


ggplot(a) + geom_sf()


nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
subplot(nrows = 2,
        ggplot(nc) + geom_sf(),
        plot_ly(nc),
        plot_geo(nc),
        plot_mapbox(nc)
) %>% hide_legend()



Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1Ijoiam1wZXJyYXVkIiwiYSI6ImNqanRvbmpnMzRmZTQzcHJtZXY0bjZma2YifQ.CVXHSaP2LkOu2csLcFtk5A')


library(plotly)
styles <- schema()$layout$layoutAttributes$mapbox$style$values
styles

#generate plot.js buttons, one for every style 
style_buttons <- lapply(styles, function(s) {
  list(label = s, method = "relayout", args = list("mapbox.style", s))
})

data(trails, package = 'mapview')

plot_mapbox(trails, color = I("black")) %>%
  layout(
    title = "Selected hiking trails in Franconia",
    mapbox = list(style = "satellite-streets"),
    updatemenus = list(list(y = 0.8, buttons = rev(style_buttons)))
  )



library(plotly)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
ggplot(nc) + geom_sf()
plot_ly(nc)
plot_geo(nc)
plot_mapbox(nc)
# %>% hide_legend()

library(plotly)
library(sf)
library(albersusa)

us_laea <- usa_sf("laea")
p <- ggplot(us_laea) + geom_sf()
ggplotly(p)

library(plotly)
library(sf)
fn <- '~/tmp/sesk_GDA94/sesk_catch.shp'
a <- sf::st_read(fn)
plot_mapbox(a)
plot_geo(a)
plot_geo(a[1])


# https://plot.ly/r/maps-sf/
# p <- plot_ly(a)

p <- ggplot(a[1]) + geom_sf()
ggplotly(p)


b <- a[1]
# https://blog.cpsievert.me/2018/01/30/learning-improving-ggplotly-geom-sf/
st_proj_info("proj")
st_proj_info("datum")


f <- function(proj='lcc') {
  c <- b %>%
    st_transform(paste0("+proj=",proj," +lat_1=-42 +lat_2=-41 +lat_0=-41.5 +lon_0=147.7 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")) 
#  %>%
#    st_simplify(TRUE, dTolerance = 4)
  ggplot(a[1]) + geom_sf()

}
ggplotly(f('lcc'))


