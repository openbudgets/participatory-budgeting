### Sample development data

## Admin roles

civio = Admin::Role.create(email: '@civio.es')

## Voters

raul    = Voter.create(email: 'raul@civio.es', verified: true)
eduardo = Voter.create(email: 'eduardo@civio.es', verified: true)

## Classifiers

# Districts
downtown  = District.create(name: 'Downtown')
suburbs   = District.create(name: 'Suburbs')
riverland = District.create(name: 'Riverland')

# Areas
environment = Area.create(name: 'Environmental Protection')
culture     = Area.create(name: 'Cultural Affairs')
sanitation  = Area.create(name: 'Sanitation')

# Tags
garbage   = Tag.create(name: 'Garbage Disposal')
bicycles  = Tag.create(name: 'Bicycles')
parks     = Tag.create(name: 'Parks and Recreation')
libraries = Tag.create(name: 'Libraries')

## Campaigns

class Semester
  def self.current
    Semester.new
  end

  def self.previous
    current.previous
  end

  def self.next
    current.next
  end

  def initialize(season=nil, year=nil)
    @season = season || Date.today.month <= 6 ? :spring : :fall
    @year   = year   || Date.today.year
  end

  def previous
    previous_semester_season = @season == :spring ? :fall : :spring
    previous_semester_year = @season == :spring ? @year - 1 : @year
    @previous ||= Semester.new(previous_semester_season, previous_semester_year)
  end

  def next
    next_semester_season = @season == :spring ? :fall : :spring
    next_semester_year = @season == :spring ? @year : @year + 1
    @next ||= Semester.new(next_semester_season, next_semester_year)
  end

  def season
    @season
  end

  def year
    @year
  end

  def start
    result = Date.new(@year)
    result += 6.months if fall?
    result
  end

  def end
    result = Date.new(@year).end_of_year
    result -= 6.months if spring?
    result
  end

  def to_s
    "#{season.capitalize} #{year}"
  end

  def spring?
    @season == :spring
  end

  def fall?
    @season == :fall
  end
end

def campaign_description_for(semester)
  case semester.season
  when :spring
    <<~EOD.gsub(/\s+/, " ").strip
      Once more, the annual Spring campaign is up for all the citizens to collaborate on the allocation
      of the second semester of current year's city budget.
    EOD
  when :fall
    <<~EOD.gsub(/\s+/, " ").strip
      Once more, the annual Fall campaign is up for all the citizens to collaborate on the allocation
      of the first semester of next year's city budget.
    EOD
  end
end

closed_campaign  =  Campaign.create(
                      title: "#{Semester.previous} Campaign",
                      budget: 114_192.56,
                      start_date: Semester.previous.start,
                      end_date: Semester.previous.end,
                      description: campaign_description_for(Semester.previous),
                      active: false
                    )
open_campaign    =  Campaign.create(
                      title: "#{Semester.current} Campaign",
                      budget: 252_343.45,
                      start_date: Semester.current.start,
                      end_date: Semester.current.end,
                      description: campaign_description_for(Semester.current),
                      active: true
                    )
pending_campaign =  Campaign.create(
                      title: "#{Semester.next} Campaign",
                      budget: 363_343.45,
                      start_date: Semester.next.start,
                      end_date: Semester.next.start,
                      description: campaign_description_for(Semester.next),
                      active: false
                    )

## Proposals

trees_1 = Proposal.create(
            title: 'Trees for Cantina Rd.',
            budget: 10_000.00,
            classifiers: [downtown, environment, parks],
            campaign: open_campaign,
            description: <<~EOD
              Cantina Rd. is lacking any type of vegetation, making it little attractive to pedestrian traffic.
              Planting some trees not only would improve the looks of the street, but also have a real impact in the air quality.
            EOD
          )
park_1  = Proposal.create(
            title: 'Playground for the Docks Quarter',
            budget: 102_344.32,
            classifiers: [riverland],
            campaign: open_campaign,
            description: <<~EOD
              The Docks quarter lacks of any infraestructure specifically tailored for children, making it difficult to go out and play.
              Building a playground in the district would save the children, and their parents, an inconvenient trip to other areas of the city.
            EOD
          )
lane_1  = Proposal.create(
            title: 'Bike Lane in Pinetree Area',
            budget: 4_510.50,
            classifiers: [suburbs, environment, bicycles],
            campaign: open_campaign,
            description: <<~EOD
              Pinetree Area is a beautiful place to go and ride your bike, but riding among the pedestrians is dangerous for both, the bikers and the pedestrians.
              Having a dedicated bike lane will improve security and make the visit more enjoyable.
            EOD
          )

trees_2 = Proposal.create(
            title: 'Trees for Rodeo Drive',
            budget: 15_250.25,
            classifiers: [suburbs, environment, parks],
            campaign: open_campaign,
            description: <<~EOD
              Rodeo Drive is lacking any type of vegetation, making it little attractive to pedestrian traffic.
              Planting some trees not only would improve the looks of the street, but also have a real impact in the air quality.
            EOD
          )
park_2  = Proposal.create(
            title: 'Playground for the Bellefleur Quarter',
            budget: 50_000.00,
            classifiers: [suburbs],
            campaign: open_campaign,
            description: <<~EOD
              The Bellefleur quarter lacks of any infraestructure specifically tailored for children, making it difficult to go out and play.
              Building a playground in the district would save the children, and their parents, an inconvenient trip to other areas of the city.
            EOD
          )
lane_2  = Proposal.create(
            title: 'Bike Lane in the Financial Center',
            budget: 14_700.00,
            classifiers: [downtown, environment, bicycles],
            campaign: open_campaign,
            description: <<~EOD
              The Fiancial Center is a place where communting by bike would be great, but riding among the cars is dangerous for both, the bikers and the drivers.
              Having a dedicated bike lane will improve security and make the trip more enjoyable.
            EOD
          )

trees_3 = Proposal.create(
            title: 'Trees for South Bridge',
            budget: 8_500.00,
            classifiers: [riverland, environment, parks],
            campaign: open_campaign,
            description: <<~EOD
              South Bridge is lacking any type of vegetation, making it little attractive to pedestrian traffic.
              Planting some trees not only would improve the looks of the street, but also have a real impact in the air quality.
            EOD
          )
park_3  = Proposal.create(
            title: 'Playground for Downtown',
            budget: 102_344.32,
            classifiers: [downtown],
            campaign: open_campaign,
            description: <<~EOD
              The Downtown district lacks of any infraestructure specifically tailored for children, making it difficult to go out and play.
              Building a playground in the district would save the children, and their parents, an inconvenient trip to other areas of the city.
            EOD
          )
lane_3  = Proposal.create(
            title: 'Bike Lane in North Bridge',
            budget: 6_130.70,
            classifiers: [riverland, environment, bicycles],
            campaign: open_campaign,
            description: <<~EOD
              North Bridge is a convenient place to go around the Riverland district, but riding your bike among the pedestrians is dangerous for both, the bikers and the pedestrians.
              Having a dedicated bike lane will improve security and make the trip more enjoyable.
            EOD
          )
