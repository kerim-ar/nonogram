#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QJsonArray>
#include <QJsonObject>
#include <QAbstractListModel>

class NonogramModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString comment READ comment WRITE setComment NOTIFY commentChanged)

public:
    enum Roles { IsColored = Qt::UserRole + 1 };

    explicit NonogramModel(QObject *parent = 0);
    ~NonogramModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    QString name() const;
    void setName(const QString &name);

    QString comment() const;
    void setComment(const QString &comment);

    Q_INVOKABLE
    int width() const;

    Q_INVOKABLE
    int height() const;

    Q_INVOKABLE
    QJsonObject toJsonObject() const;

    Q_INVOKABLE
    bool isCorrectNonogram() const;

public slots:
    void setSize(int width, int height);
    void initWithJsonObject(const QJsonObject &jsonObject);

    void toggleCell(int index);

signals:
    void nameChanged();
    void commentChanged();

private:
    QJsonArray cellsToJsonArray() const;
    void initCells(const QJsonArray &cells);

    QString m_name;
    QString m_comment;
    QVector<int> m_cells;
    int m_width;
    int m_height;
};

#endif // NONOGRAMMODEL_H
