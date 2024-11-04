Feature: Re-write path dependencies to Poetry projects as versioned package dependencies

  Scenario Outline: Re-written dependency version changes based on selected version pinning strategy
    Given a project with a local path dependencies to other Poetry projects
    When the project is built using the plugin's command-line mode with the configured "<version pinning strategy>"
    Then the re-written dependency version for "<dependency name>" becomes "<pinned version>", optional ("<optional>"), with extras: "<extras>"
    Examples:
      | dependency name | version pinning strategy | pinned version     | extras      | optional |
      | spam            | mixed                    | >=1.2.3.dev,<1.2.4 | ["testing"] | true     |
      | spam            | exact                    | 1.2.3.dev          | ["testing"] | true     |
      | spam            | semver                   | ^1.2.3.dev         | ["testing"] | true     |
      | ham             | mixed                    | 4.5.6              | []          | false    |
      | ham             | exact                    | 4.5.6              | []          | false    |
      | ham             | semver                   | ^4.5.6             | []          | false    |
      | eggs            | mixed                    | >=1.0rc4,<1.0.1    | []          | false    |