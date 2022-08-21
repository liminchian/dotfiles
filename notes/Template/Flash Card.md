# Metadata

Note_Type::Literature Note
Pronunciation::
Meanings::
POS::
Status:: 👶

---

# Questions

#flashcards

What is `= this.file.name` meanings? ->`= this.meanings`
What is pronunciation of `= this.file.name`? ->`= this.pronunciation`

---

# Compare with...

- Meanings

```dataview
list
where contains(meanings, this.meanings)
and file.name != this.file.name
```

- Prounciation

```dataview
list
where contains(pronunciation, this.pronunciation)
and file.name != this.file.name
```
