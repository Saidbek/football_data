require 'spec_helper'

describe FootballRuby::Client do
  let(:base_url) { 'http://api.football-data.org/v1' }
  let(:la_liga_id) { 436 }
  let(:barcelona_id) { 81 }

  describe '#leagues', :vcr do
    let(:response) { subject.leagues(season: 2016) }

    it 'returns a list of leagues' do
      expect(response).to be_an_instance_of(Array)
    end

    it 'includes top 4 european leagues' do
      expect(response).to include(
        a_hash_including(caption: 'Primera Division 2016/17'),
        a_hash_including(caption: 'Premier League 2016/17'),
        a_hash_including(caption: '1. Bundesliga 2016/17'),
        a_hash_including(caption: 'Serie A 2016/17')
      )
    end
  end

  describe '#league_teams', :vcr do
    let(:response) { subject.league_teams(la_liga_id) }

    it 'returns a list of teams' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'includes top teams' do
      expect(response[:teams]).to include(
        a_hash_including(name: 'FC Barcelona'),
        a_hash_including(name: 'Real Madrid CF'),
        a_hash_including(name: 'Club Atlético de Madrid'),
      )
    end
  end

  describe '#league_table', :vcr do
    let(:response) { subject.league_table(la_liga_id) }

    it 'returns a list of table' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'includes top teams' do
      expect(response[:standing]).to include(
        a_hash_including(teamName: 'FC Barcelona'),
        a_hash_including(teamName: 'Real Madrid CF'),
        a_hash_including(teamName: 'Club Atlético de Madrid'),
      )
    end
  end

  describe '#league_fixtures', :vcr do
    let(:response) { subject.league_fixtures(la_liga_id) }

    it 'returns a list of fixtures' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'includes awesome El Clásico' do
      expect(response[:fixtures]).to include(
        a_hash_including(
          homeTeamName: 'FC Barcelona',
          awayTeamName: 'Real Madrid CF',
          result: {
            goalsHomeTeam: 1,
            goalsAwayTeam: 1,
            halfTime: { goalsHomeTeam: 0, goalsAwayTeam: 0 }
          }
        ),
        a_hash_including(
          homeTeamName: 'Real Madrid CF',
          awayTeamName: 'FC Barcelona',
          result: {
            goalsHomeTeam: 2,
            goalsAwayTeam: 3,
            halfTime: { goalsHomeTeam: 1, goalsAwayTeam: 1 }
          }
        )
      )
    end
  end

  describe '#league_fixtures for a given day', :vcr do
    let(:response) { subject.league_fixtures(la_liga_id, match_day: 1) }

    it 'returns a list of fixtures' do
      expect(response).to be_an_instance_of(Hash)
    end

    it "includes FC Barcelona's first game against Real Betis" do
      expect(response[:fixtures]).to include(
        a_hash_including(
          homeTeamName: 'FC Barcelona',
          awayTeamName: 'Real Betis',
          matchday: 1,
          result: {
            goalsHomeTeam: 6,
            goalsAwayTeam: 2,
            halfTime: { goalsHomeTeam: 3, goalsAwayTeam: 1 }
          }
        )
      )
    end
  end

  describe '#fixtures', :vcr do
    let(:response) { subject.fixtures }

    it 'returns a list of fixtures' do
      expect(response).to be_an_instance_of(Hash)
    end
  end

  describe '#fixture', :vcr do
    let(:response) { subject.fixture(151875) }

    it 'returns a fixture' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'shows details of the fixture' do
      expect(response[:fixture]).to include(homeTeamName: 'Swindon Town FC', awayTeamName: 'Charlton Athletic')
    end
  end

  describe '#team_fixtures', :vcr do
    let(:response) { subject.team_fixtures(barcelona_id) }

    it 'returns a list of fixtures' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'shows details of the fixture' do
      expect(response[:fixtures]).to include(
        a_hash_including(
          homeTeamName: 'FC Barcelona',
          awayTeamName: 'Deportivo Alavés',
          status: 'FINISHED',
          date: '2016-09-10T18:30:00Z'
        )
      )
    end
  end

  describe '#team', :vcr do
    let(:response) { subject.team(barcelona_id) }

    it 'returns a list of details' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'shows details of the team' do
      expect(response).to include(name: 'FC Barcelona', code: 'FCB', shortName: 'Barcelona')
    end
  end

  describe '#team_players', :vcr do
    let(:response) { subject.team_players(barcelona_id) }

    it 'returns a list of players' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'shows details of the player' do
      expect(response[:players]).to include(
        a_hash_including(
          name: 'Lionel Messi',
          position: 'Right Wing',
          jerseyNumber: 10,
          dateOfBirth: '1987-06-24',
          nationality: 'Argentina',
        )
      )
    end
  end

  describe '#live_scores', :vcr do
    let(:response) { subject.live_scores }

    it 'returns a list of games' do
      expect(response).to be_an_instance_of(Hash)
    end

    it 'shows details of the game' do
      expect(response[:games]).to include(
        a_hash_including(
          homeTeamName: 'Granada',
          awayTeamName: 'Espanyol'
        )
      )
    end
  end
end
