\version "2.22.1"

\header {
  tagline = ##f
  title = "Pallet Town Theme"
  composer = "Composed by Junichi Masuda"
  arranger = "Arranged by PhPanda"
}

\paper{
  line-width = 158\mm
}

%% text defs
presto = \markup { \bold \italic "Presto" }
div = \markup { \bold "Div." }
nondiv = \markup { \bold "Non div." }
unis = \markup { \bold "Unis." }
piz = \markup { \bold "Pizz." }
arc = \markup { \bold "Arco" }
pizz = \set Staff.midiInstrument = "pizzicato strings"
arco = \set Staff.midiInstrument = "string ensemble 1"
pont = \markup { \bold \italic "Sul ponticello" }
naturale = \markup { \bold \italic "Naturale" }
moltocr = {
  \set crescendoText = \markup { \italic "Molto cresc." }
  \set crescendoSpanner = #'text
  \override DynamicTextSpanner.style = #'dotted-line
}
offCr = {
  \unset crescendoText
  \unset crescendoSpanner
  \revert DynamicTextSpanner.style
}

%% Layout for piano dynamics
\layout {
  \context {
    \Voice
    \override Glissando.breakable = ##t
    \override TextSpanner.breakable = ##t
    \override DynamicLineSpanner.breakable = ##t
    \override DynamicTextSpanner.breakable = ##t
    \override TrillSpanner.breakable = ##t
  }
}

%% layout to create orchestra staff group
%% with non-spanned barlines between two instrument groups
\layout {
  \context {
    \StaffGroup
    \name Orchestra
    \remove Span_bar_engraver
  }
  \context {
    \Score
    \accepts Orchestra
  }
}

%% Layout to produce SquareStaff context
%% to group similar instruments in a staff group with thin square bracket
\layout {
  \context {
    \StaffGroup
    \name SquareStaff
    systemStartDelimiter = #'SystemStartSquare
  }
  \context {
    \Orchestra
    \accepts SquareStaff
  }
  \context {
    \StaffGroup
    \accepts SquareStaff
  }
}

%% Layout to produce MarkLine context
%% to place rehearsal marks and texts above full score
\layout {
  \context {
    \type Engraver_group
    \name MarkLine
    \consists Output_property_engraver
    \consists Axis_group_engraver
    \consists Mark_engraver
    \consists Metronome_mark_engraver
    \consists Script_engraver
    \consists Text_engraver
    \consists Text_spanner_engraver
    \consists Font_size_engraver
    \override VerticalAxisGroup.staff-affinity = #DOWN
    \override VerticalAxisGroup.nonstaff-relatedstaff-spacing.padding = #2
    \override VerticalAxisGroup.nonstaff-unrelatedstaff-spacing.padding = #5
    \override TextSpanner.breakable = ##t
  }
  \context {
    \Score
    \accepts MarkLine
  }
  \context {
    \Orchestra
    \accepts MarkLine
  }
  \context {
    \StaffGroup
    \accepts MarkLine
  }
}

%% layout to produce a smaller markline
%% put before 1st violin part
\layout {
  \context {
    \MarkLine
    \name SmallMarkLine
    \override MetronomeMark.outside-staff-priority = #800
    \override RehearsalMark.outside-staff-priority = #1200
  }
  \context {
    \Score
    \accepts SmallMarkLine
  }
  \context {
    \Orchestra
    \accepts SmallMarkLine
  }
  \context {
    \StaffGroup
    \accepts SmallMarkLine
  }
}

modern =
#`(Staff ,(make-accidental-rule 'same-octave 0)
  ,(make-accidental-rule 'any-octave 0)
  ,(make-accidental-rule 'same-octave 1))

\layout {
  \context {
    \Score
    autoAccidentals = #modern
    autoCautionaries = #modern
  }
}

  marks = \relative c' {
    \set rehearsalMarkFormatter = #format-mark-box-numbers
    \tempo \presto 4=120
\set Score.currentBarNumber = #11
  }

  piccolo = \relative c'''' {
    \clef treble  \key g \major \time 4/4
    \transposition c''
  }

  flutes = \relative {
    \clef treble  \key g \major \time 4/4
  }

  oboes = \relative {
    \clef treble  \key g \major \time 4/4
  }

  clarinets = \relative c' {
    \clef treble \key g \major \time 4/4
    \transposition bes
  }

  bassoons = \relative {
    \clef bass  \key g \major \time 4/4
  }

  hornI = \relative c'' {
    \clef treble  \key g \major \time 4/4
    \transposition f
  }

  hornII = \relative c'' {
    \clef treble  \key g \major \time 4/4
    \transposition f
  }

  trumpetI = \relative c''' {
    \clef treble \key g \major \time 4/4
    \transposition bes
  }

  trumpetII = \relative c'' {
    \clef treble \key g \major \time 4/4
    \transposition bes
  }

  trombones = \relative {
    \clef tenor \key g \major \time 4/4
  }

  tuba = \relative {
    \clef bass \key g \major \time 4/4
  }

  timpani = \relative {
    \clef bass \key g \major \time 4/4
  }

  trian = {
    \clef percussion \time 4/4
  }

  cym = {
    \clef percussion \time 4/4
  }

  tamt = {
    \clef percussion \time 4/4
  }

  tamb = {
    \clef percussion \time 4/4
  }

  snare = {
    \clef percussion \time 4/4
  }

  bsdrum = {
    \clef percussion \time 4/4
  }

  harprh = \relative c'' {
    \clef treble \key g \major \time 4/4
  }

  harplh = \relative c {
    \clef bass \key g \major \time 4/4
  }

  dynamics = {

  }


  violinI = \relative {
    \clef treble \key g \major \time 4/4
  }

  violinII = \relative {
    \clef treble \key g \major \time 4/4
  }

  viola = \relative {
    \clef alto \key g \major \time 4/4
  }

  cello = \relative {
    \clef bass \key g \major \time 4/4
  }

  contrabass = \relative c {
    \clef bass \key g \major \time 4/4
    \transposition c
    g2 e2 | g1 | e1
  }

  #(set-global-staff-size 10)

  \score {
    \new Orchestra = "orchestra" <<
    \set Score.skipBars = ##f
    \new MarkLine { \marks }
      \new StaffGroup = "woodwind" <<
      \new SquareStaff = "picc fl" <<
        \new Staff = "piccolo" {
          \set Staff.instrumentName = "Piccolo"
          \set Staff.shortInstrumentName = "Picc."
        \piccolo
        }
        \new Staff = "flutes" {
          \set Staff.instrumentName = "Flutes I & II"
          \set Staff.shortInstrumentName = "Fl."
        \flutes
        }
      >>
      \new Staff = "oboes" {
        \set Staff.instrumentName = "Oboes I & II"
        \set Staff.shortInstrumentName = "Ob."
      \oboes
      }
      \new Staff = "clarinets" {
        \set Staff.instrumentName = \markup {
          \column { \line { "Clarinets I & II" }
            \line { "in B" \smaller \flat } } }
        \set Staff.shortInstrumentName = "Cl."
      \clarinets
      }
      \new Staff = "bassoons" {
        \set Staff.instrumentName = "Bassoons I & II"
        \set Staff.shortInstrumentName = "Bn."
      \bassoons
      }
    >>
    \new StaffGroup = "brass" <<
      \new SquareStaff = "horns" <<
        \new Staff = "hornsI" {
          \set Staff.instrumentName = \markup {
            \column { \line { "Horns I & II" }
              \line { "in F" } } }
          \set Staff.shortInstrumentName = "Hn. I & II"
        \hornI
        }
        \new Staff = "hornsII" {
          \set Staff.instrumentName = \markup {
            \column { \line { "Horns III & IV" }
              \line { "in F" } } }
          \set Staff.shortInstrumentName = "Hn. III & IV"
        \hornII
        }
      >>
      \new SquareStaff = "trumpets" <<
        \new Staff = "trumpetI" {
          \set Staff.instrumentName = \markup {
            \column { \line { "Trumpets I & II" }
            \line { "in B" \smaller \flat } } }
          \set Staff.shortInstrumentName = "Tp. I & II"
        \trumpetI
        }
        \new Staff = "trumpetII" {
          \set Staff.instrumentName = \markup {
            \column { \line { "Trumpet III" }
            \line { "in B" \smaller \flat } } }
          \set Staff.shortInstrumentName = "Tp. III"
        \trumpetII
        }
      >>
      \new SquareStaff = "trombones" <<
        \new Staff = "trombones 1 & 2" {
          \set Staff.instrumentName = "Trombones I & II"
          \set Staff.shortInstrumentName = "Tb. I & II"
        \trombones
        }
        \new Staff = "tuba" {
          \set Staff.instrumentName = "Bass trombone & Tuba"
          \set Staff.shortInstrumentName = "Btb. & Tu."
        \tuba
        }
      >>
    >>
    \new Staff = "timpani" {
      \set Staff.instrumentName = "Timpani in A, D & E"
      \set Staff.shortInstrumentName = "Tim."
    \timpani
    }
    \new GrandStaff = "drums" <<
      \new RhythmicStaff = "triangle" {
        \set RhythmicStaff.instrumentName = "Triangle"
        \set RhythmicStaff.shortInstrumentName = "Tri."
      \trian
      }
      \new RhythmicStaff = "cymbals" {
        \set RhythmicStaff.instrumentName = "Suspended cymbal"
        \set RhythmicStaff.shortInstrumentName = "Susp. cym."
      \cym
      }
      \new RhythmicStaff = "tamtam" {
        \set RhythmicStaff.instrumentName = "Tamtam"
        \set RhythmicStaff.shortInstrumentName = "Tamt."
      \tamt
      }
      \new RhythmicStaff = "tambourine" {
        \set RhythmicStaff.instrumentName = "Tambourine"
        \set RhythmicStaff.shortInstrumentName = "Tamb."
      \tamb
      }
      \new RhythmicStaff = "snare" {
        \set RhythmicStaff.instrumentName = "Snare drum"
        \set RhythmicStaff.shortInstrumentName = "Sn."
      \snare
      }
      \new RhythmicStaff = "bass drum" {
        \set RhythmicStaff.instrumentName = "Bass drum"
        \set RhythmicStaff.shortInstrumentName = "Bd."
      \bsdrum
      }
    >>
    \new PianoStaff = "harp" <<
      \set PianoStaff.instrumentName = "Harp"
      \set PianoStaff.shortInstrumentName = "Hrp."
      \set PianoStaff.connectArpeggios = ##t
      \new Staff = "rh" { \harprh }
      \new Dynamics { \dynamics }
      \new Staff = "lh" { \harplh }
    >>
    \new SmallMarkLine { \marks }
    \new StaffGroup = "strings" <<
      \new SquareStaff = "violins" <<
        \new Staff = "violin I" {
          \set Staff.instrumentName = "Violin I"
          \set Staff.shortInstrumentName = "Vn. I"
        \violinI
        }
        \new Staff = "violin II" {
          \set Staff.instrumentName = "Violin II"
          \set Staff.shortInstrumentName = "Vn. II"
        \violinII
        }
      >>
      \new Staff = "viola" {
        \set Staff.instrumentName = "Viola"
        \set Staff.shortInstrumentName = "Vl."
      \viola
      }
      \new SquareStaff = "Cello and Bass" <<
        \new Staff = "violoncello" {
          \set Staff.instrumentName = "Violoncello"
          \set Staff.shortInstrumentName = "Vc."
        \cello
        }
        \new Staff = "contrabass" {
          \set Staff.instrumentName = "Contrabass"
          \set Staff.shortInstrumentName = "Cb."
        \contrabass
        }
        >>
      >>
    >>
    \layout {
      \context {
        \Score
        \remove Mark_engraver
        \remove Metronome_mark_engraver
      }
      \context {
        \Staff \RemoveEmptyStaves
      }
    }
    \midi { }
  }
