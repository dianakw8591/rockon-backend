require 'open-uri'

# def getIds(areaId, parentId)
#   create area with areaId, name, parentId
#   if noMoreAreas
#     go through routes, get route ids, create new routes with areaId
#   else
#     get all subarea ids .foreach => getIds(id, areaId)
#   end

# end


def getIds(areaId, parentId)
  base_url = 'https://www.mountainproject.com/area/'
  url = base_url + areaId
  doc = Nokogiri::HTML(URI.open(url))
  #get area name and save a new area
  name = doc.css('h1')[0].children[0].text.strip
  puts('in area:', name)
  # check_area = Area.find_by(mtnproj_id: areaId)
  # if check_area
  #   check_area.parent_id = parentId
  # else
    current_area = Area.create(name: name, parent_id: parentId, mtnproj_id: areaId)
    #check for subareas
    areas = doc.css('div.lef-nav-row a')
    if areas.empty?
      #get routes from this area
      routes = doc.css('table#left-nav-route-table a')
      route_ids = routes.map { |a| a.attr('href').match(/[0-9]+/).to_s }
      route_ids.each { |route_id| Climb.create(mtnproj_id: route_id, area_id: current_area.id) }
    else
      area_ids = areas.map { |u| u.attr('href').match(/[0-9]+/).to_s }
      area_ids.each { |id| getIds(id, current_area.id)}
    end
  # end
end

# hetchy
# getIds('107751068', nil)

#ynp
getIds('105833381', nil)
