require 'spec_helper'

describe FootballData::Client do
  let(:base_url) { 'http://api.football-data.org/v1' }
  let(:year) { Time.now.year }
  let(:id) { 426 }

  subject { described_class.new }

  before do
    stub_request(:get, url).
      to_return(status: 200, body: body, headers: {'X-Auth-Token' => '31d3d417db12416abbb83e1e3f0a47a9'})
  end

  describe '#leagues' do
    let(:url) { "#{base_url}/competitions/?season=#{year}" }
    let(:body) { fixture('competitions.json') }

    it 'sends request to API' do
      subject.leagues

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.leagues

      expect(response.body).to eq(body)
    end
  end

  describe '#league_teams' do
    let(:url) { "#{base_url}/competitions/#{id}/teams" }
    let(:body) { fixture('competition_teams.json') }

    it 'sends request to API' do
      subject.league_teams(id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.league_teams(id)

      expect(response.body).to eq(body)
    end
  end

  describe '#league_table' do
    let(:url) { "#{base_url}/competitions/#{id}/leagueTable/" }
    let(:body) { fixture('league_table.json') }

    it 'sends request to API' do
      subject.league_table(id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.league_table(id)

      expect(response.body).to eq(body)
    end
  end

  describe '#league_fixtures' do
    let(:url) { "#{base_url}/competitions/#{id}/fixtures/" }
    let(:body) { fixture('league_fixtures.json') }

    it 'sends request to API' do
      subject.league_fixtures(id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.league_fixtures(id)

      expect(response.body).to eq(body)
    end
  end

  describe '#league_fixtures with matchday' do
    let(:url) { "#{base_url}/competitions/#{id}/fixtures/?matchday=1" }
    let(:body) { fixture('league_fixtures_match_day.json') }

    it 'returns body' do
      response = subject.league_fixtures(id, match_day: 1)

      expect(parse_json(response)['count']).to eq(10)
      expect(response.body).to eq(body)
    end
  end

  describe '#fixtures' do
    let(:url) { "#{base_url}/fixtures/" }
    let(:body) { fixture('fixtures.json') }

    it 'sends request to API' do
      subject.fixtures

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.fixtures

      expect(response.body).to eq(body)
    end
  end

  describe '#fixture' do
    let(:fixture_id) { 151875 }
    let(:url) { "#{base_url}/fixtures/#{fixture_id}/" }
    let(:body) { fixture('fixture.json') }

    it 'sends request to API' do
      subject.fixture(fixture_id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.fixture(fixture_id)

      expect(response.body).to eq(body)
    end
  end

  describe '#team_fixtures' do
    let(:team_id) { 81 }
    let(:url) { "#{base_url}/teams/#{team_id}/fixtures/" }
    let(:body) { fixture('team_fixtures.json') }

    it 'sends request to API' do
      subject.team_fixtures(team_id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.team_fixtures(team_id)

      expect(response.body).to eq(body)
    end
  end

  describe '#team' do
    let(:team_id) { 81 }
    let(:url) { "#{base_url}/teams/#{team_id}/" }
    let(:body) { fixture('team.json') }

    it 'sends request to API' do
      subject.team(team_id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.team(team_id)

      expect(response.body).to eq(body)
    end
  end

  describe '#team_player' do
    let(:team_id) { 81 }
    let(:url) { "#{base_url}/teams/#{team_id}/players/" }
    let(:body) { fixture('team_player.json') }

    it 'sends request to API' do
      subject.team_player(team_id)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns body' do
      response = subject.team_player(team_id)

      expect(response.body).to eq(body)
    end
  end
end
