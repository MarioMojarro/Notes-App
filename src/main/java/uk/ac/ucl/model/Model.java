package uk.ac.ucl.model;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVPrinter;
import org.apache.commons.csv.CSVRecord;

public class Model
{
  private static final String CSV_NOTE_LIST = "data/fileList.csv";

  public List<String> readFile(String fileName, int index) {
    List<String> data = new ArrayList<>();
    try (Reader reader = new FileReader(fileName);
         CSVParser csvParser = new CSVParser(reader, CSVFormat.RFC4180
                 .withFirstRecordAsHeader()
                 .withIgnoreSurroundingSpaces(true)
                 .withTrim()
                 .withQuote('"')))
    {
      for (CSVRecord csvRecord : csvParser) {
        String value = csvRecord.get(index);
        data.add(value != null ? value.trim() : "");
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    return data;
  }

  public List<String> getNoteIndexes() {
    return readFile(CSV_NOTE_LIST, 0);
  }

  public List<String> getNoteNames() {
    return readFile(CSV_NOTE_LIST, 1);
  }

  public List<String> getNoteUrls() {
    return readFile(CSV_NOTE_LIST, 2);
  }

  public List<String> getNoteTopics() {
    return readFile(CSV_NOTE_LIST, 3);
  }

  public List<String> getNoteContents() {
    return readFile(CSV_NOTE_LIST, 4);
  }

  public List<String> getNoteSummaries() {
    return readFile(CSV_NOTE_LIST, 5);
  }

  public void addNoteEntry(int index, String noteName, String fileName, String topic, String content, String summary) {
    try (FileWriter writer = new FileWriter(CSV_NOTE_LIST, true);
         CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT)) {
      csvPrinter.printRecord(index, noteName, fileName, topic, content, summary);
      csvPrinter.flush();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void updateNoteContent(int index, String newContent) {
    updateNoteField(index, newContent, "CONTENT");
  }

  public void updateNoteTopic(int index, String newTopic) {
    updateNoteField(index, newTopic, "TOPIC");
  }

  public void updateNoteSummary(int index, String newSummary) {
    updateNoteField(index, newSummary, "SUMMARY");
  }

  private void updateNoteField(int index, String newValue, String column) {
    List<List<String>> records = new ArrayList<>();
    try (Reader reader = new FileReader(CSV_NOTE_LIST);
         CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader())) {
      for (CSVRecord record : csvParser) {
        List<String> row = new ArrayList<>();
        row.add(record.get("INDEX"));
        row.add(record.get("NOTENAMES"));
        row.add(record.get("FILEURL"));
        row.add(column.equals("TOPIC") && index == Integer.parseInt(record.get("INDEX")) ? newValue : record.get("TOPIC"));
        row.add(column.equals("CONTENT") && index == Integer.parseInt(record.get("INDEX")) ? newValue : record.get("CONTENT"));
        row.add(column.equals("SUMMARY") && index == Integer.parseInt(record.get("INDEX")) ? newValue : record.get("SUMMARY"));
        records.add(row);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }

    try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(CSV_NOTE_LIST), StandardOpenOption.TRUNCATE_EXISTING);
         CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("INDEX", "NOTENAMES", "FILEURL", "TOPIC", "CONTENT", "SUMMARY"))) {
      for (List<String> record : records) {
        csvPrinter.printRecord(record);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public int getLastIndex() {
    int lastIndex = 0;
    try (Reader reader = new FileReader(CSV_NOTE_LIST);
         CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader())) {
      for (CSVRecord record : csvParser) {
        lastIndex = Integer.parseInt(record.get("INDEX"));
      }
    } catch (IOException | NumberFormatException e) {
      e.printStackTrace();
    }
    return lastIndex;
  }

  public void deleteNote(int index) {
    List<List<String>> records = new ArrayList<>();
    try (Reader reader = new FileReader(CSV_NOTE_LIST);
         CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader())) {
      for (CSVRecord record : csvParser) {
        if (Integer.parseInt(record.get("INDEX")) != index) {
          List<String> row = new ArrayList<>();
          row.add(record.get("INDEX"));
          row.add(record.get("NOTENAMES"));
          row.add(record.get("FILEURL"));
          row.add(record.get("TOPIC"));
          row.add(record.get("CONTENT"));
          row.add(record.get("SUMMARY"));
          records.add(row);
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(CSV_NOTE_LIST), StandardOpenOption.TRUNCATE_EXISTING);
         CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("INDEX", "NOTENAMES", "FILEURL", "TOPIC", "CONTENT", "SUMMARY"))) {
      for (List<String> record : records) {
        csvPrinter.printRecord(record);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void renameNote(int index, String newName) {
    List<List<String>> records = new ArrayList<>();
    boolean updated = false;

    try (Reader reader = new FileReader(CSV_NOTE_LIST);
         CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader())) {

      for (CSVRecord record : csvParser) {
        List<String> row = new ArrayList<>();
        row.add(record.get("INDEX"));
        if (index == Integer.parseInt(record.get("INDEX"))) {
          row.add(newName);
          updated = true;
        } else {
          row.add(record.get("NOTENAMES"));
        }
        row.add(record.get("FILEURL"));
        row.add(record.get("TOPIC"));
        row.add(record.get("CONTENT"));
        row.add(record.get("SUMMARY"));
        records.add(row);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    if (!updated) {
      return;
    }
    try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(CSV_NOTE_LIST), StandardOpenOption.TRUNCATE_EXISTING);
         CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("INDEX", "NOTENAMES", "FILEURL", "TOPIC", "CONTENT", "SUMMARY"))) {
      for (List<String> record : records) {
        csvPrinter.printRecord(record);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
