---
layout: post
title: "16-Bit Gleitkommazahlen: Berechnung und Umrechnung"
date: 2025-10-16
categories: informatik zahlensysteme
tags: [Informatik, Zahlensysteme, Gleitkommazahlen, Binärsystem, IEEE754, HalfPrecision]
---

# 16-Bit Gleitkommazahlen: Berechnung und Umrechnung

## Einführung

Gleitkommazahlen sind ein fundamentales Konzept in der Informatik zur Darstellung reeller Zahlen im Computer. Die 16-Bit Gleitkommazahl (auch Half-Precision Floating Point genannt) ist eine kompakte Variante, die besonders in der Grafikverarbeitung, im maschinellen Lernen und in ressourcenbeschränkten Systemen eingesetzt wird.

---

## Theoretischer Teil

### 1. Aufbau einer 16-Bit Gleitkommazahl

Eine 16-Bit Gleitkommazahl folgt dem IEEE 754-2008 Standard und besteht aus drei Komponenten:

```
┌─────┬──────────┬─────────────────────┐
│  S  │    E     │          M          │
│ 1 Bit│  5 Bits │      10 Bits       │
└─────┴──────────┴─────────────────────┘
```

- **S (Sign)**: 1 Bit für das Vorzeichen
  - 0 = positive Zahl
  - 1 = negative Zahl

- **E (Exponent)**: 5 Bits für den Exponenten
  - Bias: 15 (also 2^(5-1) - 1)
  - Wertebereich: 0 bis 31
  - Tatsächlicher Exponent = E - 15

- **M (Mantisse/Fraction)**: 10 Bits für die Mantisse
  - Repräsentiert die Nachkommastellen
  - Implizit führende 1 (bei normalisierten Zahlen)

### 2. Mathematische Darstellung

Die allgemeine Formel zur Berechnung einer 16-Bit Gleitkommazahl lautet:

```
Wert = (-1)^S × 1.M × 2^(E-15)
```

Wobei:
- **S** das Vorzeichenbit ist
- **E** der kodierte Exponent (0-31)
- **M** die Mantisse als Binärbruch interpretiert wird
- **15** der Bias des Exponenten ist

### 3. Wertebereiche

- **Kleinste positive normalisierte Zahl**: 2^(-14) ≈ 6.104 × 10^(-5) (Exponent = 1, Mantisse = 0)
- **Größte normalisierte Zahl**: (2 - 2^(-10)) × 2^15 = 65504 (Exponent = 30, Mantisse = alle 1en)
- **Genauigkeit**: ca. 3-4 Dezimalstellen

**Hinweis**: Der Exponent 0 ist für denormalisierte Zahlen reserviert, der Exponent 31 für ±∞ und NaN.

---

## Praktische Aufgaben

### Aufgabe 1: Basis-Umrechnung (Dezimal → Binär)

**Wandeln Sie die Dezimalzahl 3.75 in das 16-Bit Gleitkommaformat um.**

#### Lösungsschritte:

**Schritt 1: Vorzeichen bestimmen**
- 3.75 ist positiv → S = 0

**Schritt 2: Dezimalzahl in Binärdarstellung umwandeln**
```
3.75₁₀ = 11.11₂

Begründung:
- Ganzzahl: 3₁₀ = 11₂
- Nachkomma: 0.75 = 0.5 + 0.25 = 2^(-1) + 2^(-2) = 0.11₂
- Ergebnis: 11.11₂
```

**Schritt 3: Normalisierung**
```
11.11₂ = 1.111₂ × 2^1

Die Zahl wird so verschoben, dass vor dem Komma genau eine 1 steht.
```

**Schritt 4: Exponent berechnen**
```
Tatsächlicher Exponent = 1
Kodierter Exponent = 1 + 15 = 16
16₁₀ = 10000₂
```

**Schritt 5: Mantisse extrahieren**
```
Normalisierte Form: 1.111₂
Mantisse (ohne führende 1): .111
In 10 Bits: 1110000000₂
```

**Schritt 6: Zusammensetzen**
```
┌───┬──────────┬─────────────────────┐
│ 0 │  10000   │   1110000000        │
└───┴──────────┴─────────────────────┘
  S      E              M

Vollständige Binärdarstellung: 0 10000 1110000000
In Hexadezimal: 0x4370
```

**Ergebnis**: 3.75₁₀ = `0 10000 1110000000`₂

---

### Aufgabe 2: Fortgeschrittene Berechnung (Binär → Dezimal)

**Gegeben ist folgende 16-Bit Gleitkommazahl in binärer Darstellung:**
```
0 10000 1100000000
```

#### a) Bestimmen Sie die Dezimalzahl

**Lösungsschritte:**

**Schritt 1: Komponenten identifizieren**
```
S (Vorzeichen):  0         → positive Zahl
E (Exponent):    10000₂    → 16₁₀
M (Mantisse):    1100000000₂
```

**Schritt 2: Tatsächlichen Exponenten berechnen**
```
Tatsächlicher Exponent = E - 15
                       = 16 - 15
                       = 1
```

**Schritt 3: Vollständige Mantisse rekonstruieren**
```
Mit impliziter führender 1: 1.1100000000₂

Dies entspricht:
1 × 2^0  = 1
1 × 2^(-1) = 0.5
1 × 2^(-2) = 0.25
────────────────
Summe      = 1.75
```

**Schritt 4: Endwert berechnen**
```
Wert = (-1)^S × 1.M × 2^(E-15)
     = (-1)^0 × 1.75 × 2^1
     = 1 × 1.75 × 2
     = 3.5
```

**Ergebnis**: Die Dezimalzahl ist **3.5**

#### b) Erklärung jeden Schritts der Umrechnung

1. **Parsing der Bitfolge**: Zunächst wird die 16-Bit Sequenz in ihre drei Komponenten (S, E, M) aufgeteilt.

2. **Vorzeichenbestimmung**: Das erste Bit (S=0) zeigt an, dass die Zahl positiv ist.

3. **Exponent-Dekodierung**: Die 5 Exponentenbits werden als vorzeichenlose Binärzahl interpretiert und der Bias (15) wird subtrahiert, um den tatsächlichen Exponenten zu erhalten.

4. **Mantissen-Dekodierung**: Die 10 Mantissenbits werden als Binärbruch interpretiert. Die implizite führende 1 wird hinzugefügt (bei normalisierten Zahlen).

5. **Berechnung**: Mit der Formel (-1)^S × 1.M × 2^(E-15) wird der finale Dezimalwert berechnet.

---

### Aufgabe 3: Spezialfälle

**Wie werden folgende Werte im 16-Bit Format dargestellt?**

#### a) Die Zahl 0 (Null)

Es gibt zwei Darstellungen für Null:

**Positive Null (+0)**:
```
0 00000 0000000000
│   │        │
│   │        └─ Mantisse: alle Nullen
│   └────────── Exponent: 0
└──────────────── Vorzeichen: positiv
```

**Negative Null (-0)**:
```
1 00000 0000000000
│   │        │
│   │        └─ Mantisse: alle Nullen
│   └────────── Exponent: 0
└──────────────── Vorzeichen: negativ
```

**Regel**: Wenn Exponent = 0 und Mantisse = 0, dann repräsentiert die Zahl 0.

#### b) Unendlich (∞)

**Positiv Unendlich (+∞)**:
```
0 11111 0000000000
│   │        │
│   │        └─ Mantisse: alle Nullen
│   └────────── Exponent: maximaler Wert (31)
└──────────────── Vorzeichen: positiv
```

**Negativ Unendlich (-∞)**:
```
1 11111 0000000000
│   │        │
│   │        └─ Mantisse: alle Nullen
│   └────────── Exponent: maximaler Wert (31)
└──────────────── Vorzeichen: negativ
```

**Regel**: Wenn Exponent = 31 (alle Einsen) und Mantisse = 0, dann repräsentiert die Zahl ±∞.

**Entstehung**: Unendlich entsteht durch:
- Division durch Null (z.B., 1.0 / 0.0 = +∞)
- Überlauf bei Berechnungen (Zahl zu groß für Darstellung)

#### c) NaN (Not a Number)

**NaN-Darstellung**:
```
S 11111 MMMMMMMMMM
│   │        │
│   │        └─ Mantisse: mindestens ein Bit ≠ 0
│   └────────── Exponent: maximaler Wert (31)
└──────────────── Vorzeichen: beliebig

Beispiele:
0 11111 0000000001  (Quiet NaN)
0 11111 1000000000  (Quiet NaN)
1 11111 0100000000  (Signaling NaN)
```

**Regel**: Wenn Exponent = 31 (alle Einsen) und Mantisse ≠ 0, dann repräsentiert die Zahl NaN.

**Unterscheidung**:
- **Quiet NaN (qNaN)**: Höchstes Mantissenbit = 1
- **Signaling NaN (sNaN)**: Höchstes Mantissenbit = 0, aber mindestens ein anderes Bit = 1

**Entstehung**: NaN entsteht durch:
- 0 / 0
- ∞ - ∞
- ∞ / ∞
- √(-1) (Quadratwurzel einer negativen Zahl)
- Ungültige Operationen

---

## Lösungshinweise für weitere Übungen

### Allgemeine Vorgehensweise: Dezimal → 16-Bit

1. **Vorzeichen**: Bestimme, ob die Zahl positiv (S=0) oder negativ (S=1) ist
2. **Binärumwandlung**: Wandle die Dezimalzahl (ohne Vorzeichen) in Binär um
3. **Normalisierung**: Verschiebe das Binärkomma, bis vor dem Komma genau 1.xxx steht
4. **Exponent**: Zähle die Verschiebungen und addiere den Bias (15)
5. **Mantisse**: Nimm die Nachkommastellen (ohne die führende 1) und fülle auf 10 Bits auf
6. **Zusammensetzen**: S (1 Bit) | E (5 Bits) | M (10 Bits)

### Allgemeine Vorgehensweise: 16-Bit → Dezimal

1. **Aufteilen**: Separiere S, E, M aus der 16-Bit Sequenz
2. **Sonderfall prüfen**: 
   - E = 0 und M = 0 → 0
   - E = 31 und M = 0 → ±∞
   - E = 31 und M ≠ 0 → NaN
3. **Exponent**: Berechne den tatsächlichen Exponenten (E - 15)
4. **Mantisse**: Füge die implizite 1 hinzu und interpretiere als Binärbruch
5. **Berechnen**: Wende die Formel (-1)^S × 1.M × 2^(E-15) an

### Häufige Fehlerquellen

❌ **Vergessen des Bias**: Der Exponent muss immer mit dem Bias (15) verrechnet werden

❌ **Implizite 1 vergessen**: Bei normalisierten Zahlen ist die führende 1 implizit

❌ **Falsche Normalisierung**: Die normalisierte Form muss immer 1.xxx sein, nicht 0.xxx

❌ **Binärbruch-Umwandlung**: Bei der Umwandlung von Dezimal-Nachkommastellen in Binär multiplizieren, nicht dividieren

### Übungsaufgaben zum Selbststudium

**Leicht**:
1. Wandle 7.5 in 16-Bit Gleitkomma um
2. Bestimme den Dezimalwert von: 0 10010 1000000000

**Mittel**:
3. Wandle -12.25 in 16-Bit Gleitkomma um
4. Bestimme den Dezimalwert von: 1 01110 0100000000

**Schwer**:
5. Wandle 0.1 in 16-Bit Gleitkomma um (Hinweis: periodischer Binärbruch!)
6. Was ist der kleinste positive Wert, der noch normalisiert dargestellt werden kann?

---

## Zusätzliche Informationen

### Vergleich mit anderen Gleitkommaformaten

| Format | Bits | Vorzeichen | Exponent | Mantisse | Bias | Wertebereich (ca.) |
|--------|------|------------|----------|----------|------|--------------------|
| Half (Float16) | 16 | 1 | 5 | 10 | 15 | ±6.55×10^4 |
| Single (Float32) | 32 | 1 | 8 | 23 | 127 | ±3.40×10^38 |
| Double (Float64) | 64 | 1 | 11 | 52 | 1023 | ±1.80×10^308 |

### Anwendungsgebiete von 16-Bit Gleitkommazahlen

- **Deep Learning**: Reduzierter Speicherbedarf bei neuronalen Netzen
- **Grafikverarbeitung**: Schnellere Berechnungen auf GPUs
- **Mobile Geräte**: Energieeffizienz durch geringere Datenmenge
- **Computer Vision**: Bildverarbeitung mit ausreichender Genauigkeit
- **Audio-Verarbeitung**: Kompaktere Darstellung von Audiosignalen

### Weiterführende Ressourcen

- IEEE 754-2008 Standard (offizielle Spezifikation)
- Visualisierung: [Float Toy](https://evanw.github.io/float-toy/)
- Half-Precision Konverter: Online-Tools zur Verifikation

---

## Zusammenfassung

16-Bit Gleitkommazahlen bieten einen Kompromiss zwischen Speichereffizienz und Genauigkeit. Sie folgen dem IEEE 754-2008 Standard mit 1 Bit Vorzeichen, 5 Bits Exponent (Bias 15) und 10 Bits Mantisse. Die mathematische Formel (-1)^S × 1.M × 2^(E-15) ermöglicht die Darstellung von Zahlen im Bereich von etwa 6×10^(-5) bis 6.5×10^4 mit einer Genauigkeit von 3-4 Dezimalstellen.

**Wichtigste Erkenntnisse**:
- Normalisierung verschiebt das Komma zu 1.xxx
- Der Bias (15) muss immer berücksichtigt werden
- Spezialfälle (0, ±∞, NaN) haben besondere Kodierungen
- Die implizite führende 1 bei normalisierten Zahlen erhöht die Genauigkeit

---

*Dieser Beitrag wurde als Lernressource für Studenten der technischen Informatik erstellt und deckt die grundlegenden Konzepte der 16-Bit Gleitkommadarstellung ab.*
