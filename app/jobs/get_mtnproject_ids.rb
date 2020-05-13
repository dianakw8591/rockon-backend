require 'open-uri'

def getIds(areaId, parentId)
  base_url = 'https://www.mountainproject.com/area/'
  url = base_url + areaId
  doc = Nokogiri::HTML(URI.open(url))
  #get area name and save a new area
  name = doc.css('h1')[0].children[0].text.strip
  puts('in area:', name)
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
end

# hetchy
# getIds('107751068', nil)

#ynp
# getIds('105833381', nil)

#California '105708959'
#Alabama '105905173'
#Alaska 105909311
#Arizona 105708962
#Arkansas 105901027
# Colorado 105708956
# Connecticut 105806977
#Delaware 106861605
#Florida 111721391
#Georgia 105897947
#Hawaii 106316122
#Idaho 105708958
#Illinois 105911816
#Indiana 112389571
#Iowa 106092653
#Kansas 107235316
#Kentucky 105868674
#Louisiana 116720343
#Maine 105948977
#Maryland 106029417
#Massachusetts 105908062
#Michigan 106113246
#Minnessota 105812481
#Mississippi 108307056
#Missouri 105899020
#Montana 105907492
#Nebraska 116096758
#Nevada 105708961
#New Hampshire 105872225
#New Jersey 106374428
#New Mexico 105708964
#New York 105800424
#North Carolina 105873282
#North Dakota 106598130
#Ohio 105994953
#Oklahoma 105854466
#Oregon 105708965
#Pennsylvania 105913279
#Rhode Island 106842810
#South Carolina 107638915
#South Dakota 105708963
#Tennessee 105887760
#Texas 105835804
#Utah 105708957
#vermont 105891603
#virginia 105852400
#Washington 105708966
#WEst virgina 105855459
#Wisconsin 105708968
#Wyoming 105708960
#international 105907743


#hawaii - kansas
# ['106316122', '105708958', '105911816', '112389571', '106092653', '107235316'].map { |id| getIds(id, nil)}

#Kentuck-michigan
# ['105868674', '116720343', '105948977', '106029417', '105908062', '106113246'].map { |id| getIds(id, nil)}

#Minnesota - Nevada DO THIS ONE NEXT
['105812481', '108307056', '105899020', '105907492', '116096758', '105708961'].map { |id| getIds(id, nil)}

#NH - NM
# ['105872225', '106374428', '105708964'].map { |id| getIds(id, nil)}

#NY to Oklahoma
# ['105800424', '105873282', '106598130', '105994953', '105854466']

#OR to SD
# ['105708965', '105913279', '106842810', '107638915', '105708963']

#TN, TX
# ['105887760', '105835804']

#UT
# getIds('105708957', nil)

#VT to WA
# ['105891603', '105852400', '105708966']

#west virginia - WY
# ['105855459', '105708968', '105708960']

#intl (done)
# getIds('105907743', nil)

# getIds(id, nil)
# command to run this file with rails: rails runner app/jobs/get_mtnproject_ids.rb   
