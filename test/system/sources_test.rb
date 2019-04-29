require "application_system_test_case"

class SourcesTest < ApplicationSystemTestCase
  setup do
    @source = sources(:one)
  end

  test "visiting the index" do
    visit sources_url
    assert_selector "h1", text: "Sources"
  end

  test "creating a Source" do
    visit sources_url
    click_on "New Source"

    fill_in "Feed url", with: @source.feed_url
    fill_in "Lookup cost", with: @source.lookup_cost
    fill_in "Lookup description", with: @source.lookup_description
    fill_in "Lookup end time", with: @source.lookup_end_time
    fill_in "Lookup", with: @source.lookup_id
    fill_in "Lookup name", with: @source.lookup_name
    fill_in "Lookup start time", with: @source.lookup_start_time
    fill_in "Lookup url", with: @source.lookup_url
    fill_in "Type", with: @source.type
    click_on "Create Source"

    assert_text "Source was successfully created"
    click_on "Back"
  end

  test "updating a Source" do
    visit sources_url
    click_on "Edit", match: :first

    fill_in "Feed url", with: @source.feed_url
    fill_in "Lookup cost", with: @source.lookup_cost
    fill_in "Lookup description", with: @source.lookup_description
    fill_in "Lookup end time", with: @source.lookup_end_time
    fill_in "Lookup", with: @source.lookup_id
    fill_in "Lookup name", with: @source.lookup_name
    fill_in "Lookup start time", with: @source.lookup_start_time
    fill_in "Lookup url", with: @source.lookup_url
    fill_in "Type", with: @source.type
    click_on "Update Source"

    assert_text "Source was successfully updated"
    click_on "Back"
  end

  test "destroying a Source" do
    visit sources_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Source was successfully destroyed"
  end
end
